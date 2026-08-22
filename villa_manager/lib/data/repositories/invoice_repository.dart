import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/booking_utils.dart';
import '../database/app_database.dart';

class InvoiceWithTotal {
  InvoiceWithTotal({
    required this.invoice,
    required this.total,
    required this.paidAmount,
  });
  final Invoice invoice;
  final int total;
  final int paidAmount;

  int get remainingBalance {
    final remaining = total - paidAmount;
    return remaining > 0 ? remaining : 0;
  }

  String get effectiveStatus {
    if (paidAmount >= total && total > 0) return 'paid';
    if (paidAmount > 0) return 'partial';
    return 'unpaid';
  }
}

class InvoiceDetail {
  InvoiceDetail({
    required this.invoice,
    required this.items,
    required this.payments,
  });
  final Invoice invoice;
  final List<InvoiceItem> items;
  final List<InvoicePayment> payments;

  int get total {
    var s = 0;
    for (final i in items) {
      s += i.qty * i.price;
    }
    return s;
  }

  int get paidAmount {
    var s = 0;
    for (final p in payments) {
      s += p.amount;
    }
    return s;
  }

  int get remainingBalance {
    final remaining = total - paidAmount;
    return remaining > 0 ? remaining : 0;
  }

  String get effectiveStatus {
    if (paidAmount >= total && total > 0) return 'paid';
    if (paidAmount > 0) return 'partial';
    return 'unpaid';
  }

  String get statusLabel => switch (effectiveStatus) {
    'paid' => 'LUNAS',
    'partial' => 'DP DITERIMA',
    _ => 'BELUM LUNAS',
  };
}

class InvoiceRepository {
  InvoiceRepository(this._db);
  final AppDatabase _db;
  static const _uuid = Uuid();

  Stream<List<InvoiceWithTotal>> watchAll({String? search}) {
    final term = search?.trim().toLowerCase();
    final hasSearch = term != null && term.isNotEmpty;
    final variables = <Variable>[];
    if (hasSearch) {
      variables.addAll([
        Variable.withString(term),
        Variable.withString(term),
        Variable.withString(term),
      ]);
    }

    return _db
        .customSelect(
          '''
          SELECT invoices.*,
                 COALESCE((
                   SELECT SUM(qty * price)
                   FROM invoice_items
                   WHERE invoice_id = invoices.id
                 ), 0) AS total,
                 COALESCE((
                   SELECT SUM(amount)
                   FROM invoice_payments
                   WHERE invoice_id = invoices.id
                 ), 0) AS paid_amount
          FROM invoices
          ${hasSearch ? '''
          WHERE INSTR(LOWER(guest_name), ?) > 0
             OR INSTR(LOWER(invoice_number), ?) > 0
             OR INSTR(LOWER(villa_name), ?) > 0
          ''' : ''}
          ORDER BY date_issued DESC
          ''',
          variables: variables,
          readsFrom: {_db.invoices, _db.invoiceItems, _db.invoicePayments},
        )
        .watch()
        .map(
          (rows) => rows
              .map(
                (row) => InvoiceWithTotal(
                  invoice: _db.invoices.map(row.data),
                  total: row.read<int>('total'),
                  paidAmount: row.read<int>('paid_amount'),
                ),
              )
              .toList(),
        );
  }

  Future<InvoiceDetail?> getDetail(String id) async {
    final inv = await (_db.select(
      _db.invoices,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (inv == null) return null;
    final items = await (_db.select(
      _db.invoiceItems,
    )..where((t) => t.invoiceId.equals(id))).get();
    final payments =
        await (_db.select(_db.invoicePayments)
              ..where((t) => t.invoiceId.equals(id))
              ..orderBy([(t) => OrderingTerm.asc(t.datePaid)]))
            .get();
    return InvoiceDetail(invoice: inv, items: items, payments: payments);
  }

  Future<Invoice?> byBookingId(String bookingId) => (_db.select(
    _db.invoices,
  )..where((t) => t.bookingId.equals(bookingId))).getSingleOrNull();

  Stream<Set<String>> watchBookingIdsWithInvoice() {
    return (_db.selectOnly(
      _db.invoices,
    )..addColumns([_db.invoices.bookingId])).watch().map(
      (rows) => rows.map((r) => r.read(_db.invoices.bookingId)!).toSet(),
    );
  }

  Future<int> _total(String invoiceId) async {
    final items = await (_db.select(
      _db.invoiceItems,
    )..where((t) => t.invoiceId.equals(invoiceId))).get();
    var s = 0;
    for (final i in items) {
      s += i.qty * i.price;
    }
    return s;
  }

  Future<String> _nextNumber(DateTime issued) async {
    final prefix = 'INV-${DateFormat('yyyyMM').format(issued)}-';
    final existing = await (_db.select(
      _db.invoices,
    )..where((t) => t.invoiceNumber.like('$prefix%'))).get();
    var maxN = 0;
    for (final e in existing) {
      final part = e.invoiceNumber.split('-').last;
      final n = int.tryParse(part) ?? 0;
      if (n > maxN) maxN = n;
    }
    return '$prefix${(maxN + 1).toString().padLeft(3, '0')}';
  }

  /// Create invoice from booking with one line item for stay nights.
  Future<String> createFromBooking({
    required Booking booking,
    required String villaName,
  }) async {
    return _db.transaction(() async {
      final existing = await byBookingId(booking.id);
      if (existing != null) return existing.id;

      final now = DateTime.now();
      final id = _uuid.v4();
      final nights = nightsBetween(booking.checkIn, booking.checkOut);
      if (nights < 1) throw ArgumentError('Durasi booking tidak valid');

      await _db
          .into(_db.invoices)
          .insert(
            InvoicesCompanion.insert(
              id: id,
              invoiceNumber: await _nextNumber(now),
              bookingId: booking.id,
              guestName: booking.guestName,
              villaName: villaName,
              checkIn: booking.checkIn,
              checkOut: booking.checkOut,
              commissionTypeSnapshot: Value(booking.commissionTypeSnapshot),
              commissionPercentSnapshot: Value(
                booking.commissionPercentSnapshot,
              ),
              commissionFixedSnapshot: Value(booking.commissionFixedSnapshot),
              dateIssued: now,
            ),
          );
      await _db
          .into(_db.invoiceItems)
          .insert(
            InvoiceItemsCompanion.insert(
              id: _uuid.v4(),
              invoiceId: id,
              description: 'Menginap $nights malam - $villaName',
              qty: Value(nights),
              price: Value(booking.pricePerNightSnapshot),
            ),
          );
      return id;
    });
  }

  Future<void> addItem({
    required String invoiceId,
    required String description,
    required int qty,
    required int price,
  }) async {
    if (description.trim().isEmpty) {
      throw ArgumentError.value(description, 'description', 'Wajib diisi');
    }
    if (qty < 1) throw ArgumentError.value(qty, 'qty', 'Minimal 1');
    if (price < 0) {
      throw ArgumentError.value(price, 'price', 'Tidak boleh negatif');
    }
    await _db.transaction(() async {
      await _db
          .into(_db.invoiceItems)
          .insert(
            InvoiceItemsCompanion.insert(
              id: _uuid.v4(),
              invoiceId: invoiceId,
              description: description.trim(),
              qty: Value(qty),
              price: Value(price),
            ),
          );
      await _syncInvoiceStatus(invoiceId);
    });
  }

  Future<void> deleteItem(String invoiceId, String itemId) async {
    await _db.transaction(() async {
      final detail = await getDetail(invoiceId);
      if (detail == null) throw StateError('Invoice tidak ditemukan');
      final item = detail.items.where((row) => row.id == itemId).firstOrNull;
      if (item == null) throw StateError('Item invoice tidak ditemukan');
      final newTotal = detail.total - item.qty * item.price;
      if (newTotal <= 0 || detail.paidAmount > newTotal) {
        throw StateError(
          'Item tidak dapat dihapus karena pembayaran sudah tercatat',
        );
      }
      final deleted =
          await (_db.delete(_db.invoiceItems)..where(
                (t) => t.id.equals(itemId) & t.invoiceId.equals(invoiceId),
              ))
              .go();
      if (deleted != 1) throw StateError('Item invoice tidak ditemukan');
      await _syncInvoiceStatus(invoiceId);
    });
  }

  Future<void> addPayment({
    required String invoiceId,
    required int amount,
    DateTime? datePaid,
    String paymentMethod = 'Transfer Bank',
    String notes = '',
  }) async {
    if (amount <= 0) {
      throw ArgumentError.value(amount, 'amount', 'Harus lebih dari 0');
    }
    await _db.transaction(() async {
      final detail = await getDetail(invoiceId);
      if (detail == null) throw StateError('Invoice tidak ditemukan');
      if (amount > detail.remainingBalance) {
        throw ArgumentError('Pembayaran melebihi sisa tagihan');
      }
      await _db
          .into(_db.invoicePayments)
          .insert(
            InvoicePaymentsCompanion.insert(
              id: _uuid.v4(),
              invoiceId: invoiceId,
              amount: Value(amount),
              datePaid: datePaid ?? DateTime.now(),
              paymentMethod: Value(paymentMethod.trim()),
              notes: Value(notes.trim()),
            ),
          );
      await _syncInvoiceStatus(invoiceId);
    });
  }

  Future<void> deletePayment(String invoiceId, String paymentId) async {
    await _db.transaction(() async {
      final deleted =
          await (_db.delete(_db.invoicePayments)..where(
                (t) => t.id.equals(paymentId) & t.invoiceId.equals(invoiceId),
              ))
              .go();
      if (deleted != 1) throw StateError('Pembayaran tidak ditemukan');
      await _syncInvoiceStatus(invoiceId);
    });
  }

  Future<void> clearPayments(String invoiceId) async {
    await _db.transaction(() async {
      await (_db.delete(
        _db.invoicePayments,
      )..where((t) => t.invoiceId.equals(invoiceId))).go();
      await _syncInvoiceStatus(invoiceId);
    });
  }

  Future<void> _syncInvoiceStatus(String invoiceId) async {
    final total = await _total(invoiceId);
    final payments =
        await (_db.select(_db.invoicePayments)
              ..where((t) => t.invoiceId.equals(invoiceId))
              ..orderBy([(t) => OrderingTerm.asc(t.datePaid)]))
            .get();
    final paid = payments.fold<int>(0, (sum, payment) => sum + payment.amount);
    String status = 'unpaid';
    DateTime? datePaid;
    if (paid >= total && total > 0) {
      status = 'paid';
      var runningTotal = 0;
      for (final payment in payments) {
        runningTotal += payment.amount;
        if (runningTotal >= total) {
          datePaid = payment.datePaid;
          break;
        }
      }
    } else if (paid > 0) {
      status = 'partial';
    }

    await (_db.update(
      _db.invoices,
    )..where((t) => t.id.equals(invoiceId))).write(
      InvoicesCompanion(status: Value(status), datePaid: Value(datePaid)),
    );
  }

  Future<void> markReminderSent(String id) {
    return (_db.update(_db.invoices)..where((t) => t.id.equals(id))).write(
      InvoicesCompanion(reminderSentAt: Value(DateTime.now())),
    );
  }

  Future<int> countOverdueUnpaid({int olderThanDays = 3}) async {
    final cutoff = DateTime.now().subtract(Duration(days: olderThanDays));
    final row = await _db
        .customSelect(
          '''
      SELECT COUNT(*) AS count
      FROM invoices
      WHERE status != 'paid' AND date_issued < ?
      ''',
          variables: [Variable.withDateTime(cutoff)],
        )
        .getSingle();
    return row.read<int>('count');
  }

  Stream<int> watchOverdueUnpaid() {
    return _db
        .customSelect(
          'SELECT 1',
          readsFrom: {_db.invoices, _db.invoiceItems, _db.invoicePayments},
        )
        .watch()
        .asyncMap((_) => countOverdueUnpaid());
  }

  Future<void> delete(String id) async {
    final deleted = await (_db.delete(
      _db.invoices,
    )..where((t) => t.id.equals(id))).go();
    if (deleted != 1) throw StateError('Invoice tidak ditemukan');
  }
}
