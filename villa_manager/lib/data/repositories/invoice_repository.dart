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

  int get remainingBalance => (total - paidAmount).clamp(0, 999999999);

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

  int get remainingBalance => (total - paidAmount).clamp(0, 999999999);

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
    final q = _db.select(_db.invoices)
      ..orderBy([(t) => OrderingTerm.desc(t.dateIssued)]);
    return q.watch().asyncMap((list) async {
      final out = <InvoiceWithTotal>[];
      for (final inv in list) {
        if (search != null && search.trim().isNotEmpty) {
          final s = search.trim().toLowerCase();
          if (!inv.guestName.toLowerCase().contains(s) &&
              !inv.invoiceNumber.toLowerCase().contains(s) &&
              !inv.villaName.toLowerCase().contains(s)) {
            continue;
          }
        }
        final total = await _total(inv.id);
        final paid = await _paidTotal(inv.id);
        out.add(InvoiceWithTotal(
          invoice: inv,
          total: total,
          paidAmount: paid,
        ));
      }
      return out;
    });
  }

  Future<InvoiceDetail?> getDetail(String id) async {
    final inv = await (_db.select(_db.invoices)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (inv == null) return null;
    final items = await (_db.select(_db.invoiceItems)
          ..where((t) => t.invoiceId.equals(id)))
        .get();
    final payments = await (_db.select(_db.invoicePayments)
          ..where((t) => t.invoiceId.equals(id))
          ..orderBy([(t) => OrderingTerm.asc(t.datePaid)]))
        .get();
    return InvoiceDetail(
      invoice: inv,
      items: items,
      payments: payments,
    );
  }

  Future<Invoice?> byBookingId(String bookingId) =>
      (_db.select(_db.invoices)..where((t) => t.bookingId.equals(bookingId)))
          .getSingleOrNull();

  Stream<Set<String>> watchBookingIdsWithInvoice() {
    return (_db.selectOnly(_db.invoices)
          ..addColumns([_db.invoices.bookingId]))
        .watch()
        .map((rows) =>
            rows.map((r) => r.read(_db.invoices.bookingId)!).toSet());
  }

  Future<int> _total(String invoiceId) async {
    final items = await (_db.select(_db.invoiceItems)
          ..where((t) => t.invoiceId.equals(invoiceId)))
        .get();
    var s = 0;
    for (final i in items) {
      s += i.qty * i.price;
    }
    return s;
  }

  Future<int> _paidTotal(String invoiceId) async {
    final payments = await (_db.select(_db.invoicePayments)
          ..where((t) => t.invoiceId.equals(invoiceId)))
        .get();
    var s = 0;
    for (final p in payments) {
      s += p.amount;
    }
    return s;
  }

  Future<String> _nextNumber(DateTime issued) async {
    final prefix = 'INV-${DateFormat('yyyyMM').format(issued)}-';
    final existing = await (_db.select(_db.invoices)
          ..where((t) => t.invoiceNumber.like('$prefix%')))
        .get();
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
    final existing = await byBookingId(booking.id);
    if (existing != null) return existing.id;

    final now = DateTime.now();
    final id = _uuid.v4();
    final nights = nightsBetween(booking.checkIn, booking.checkOut);
    await _db.into(_db.invoices).insert(InvoicesCompanion.insert(
          id: id,
          invoiceNumber: await _nextNumber(now),
          bookingId: booking.id,
          guestName: booking.guestName,
          villaName: villaName,
          checkIn: booking.checkIn,
          checkOut: booking.checkOut,
          dateIssued: now,
        ));
    await _db.into(_db.invoiceItems).insert(InvoiceItemsCompanion.insert(
          id: _uuid.v4(),
          invoiceId: id,
          description: 'Menginap $nights malam - $villaName',
          qty: Value(nights < 1 ? 1 : nights),
          price: Value(booking.pricePerNightSnapshot),
        ));
    return id;
  }

  Future<void> addItem({
    required String invoiceId,
    required String description,
    required int qty,
    required int price,
  }) async {
    await _db.into(_db.invoiceItems).insert(InvoiceItemsCompanion.insert(
          id: _uuid.v4(),
          invoiceId: invoiceId,
          description: description,
          qty: Value(qty),
          price: Value(price),
        ));
    await _syncInvoiceStatus(invoiceId);
  }

  Future<void> deleteItem(String invoiceId, String itemId) async {
    await (_db.delete(_db.invoiceItems)..where((t) => t.id.equals(itemId))).go();
    await _syncInvoiceStatus(invoiceId);
  }

  Future<void> addPayment({
    required String invoiceId,
    required int amount,
    DateTime? datePaid,
    String paymentMethod = 'Transfer Bank',
    String notes = '',
  }) async {
    await _db.into(_db.invoicePayments).insert(InvoicePaymentsCompanion.insert(
          id: _uuid.v4(),
          invoiceId: invoiceId,
          amount: Value(amount),
          datePaid: datePaid ?? DateTime.now(),
          paymentMethod: Value(paymentMethod),
          notes: Value(notes),
        ));
    await _syncInvoiceStatus(invoiceId);
  }

  Future<void> deletePayment(String invoiceId, String paymentId) async {
    await (_db.delete(_db.invoicePayments)
          ..where((t) => t.id.equals(paymentId)))
        .go();
    await _syncInvoiceStatus(invoiceId);
  }

  Future<void> _syncInvoiceStatus(String invoiceId) async {
    final total = await _total(invoiceId);
    final paid = await _paidTotal(invoiceId);
    String status = 'unpaid';
    DateTime? datePaid;
    if (paid >= total && total > 0) {
      status = 'paid';
      datePaid = DateTime.now();
    } else if (paid > 0) {
      status = 'partial';
    }

    await (_db.update(_db.invoices)..where((t) => t.id.equals(invoiceId)))
        .write(InvoicesCompanion(
      status: Value(status),
      datePaid: Value(datePaid),
    ));
  }

  Future<void> markReminderSent(String id) {
    return (_db.update(_db.invoices)..where((t) => t.id.equals(id))).write(
      InvoicesCompanion(reminderSentAt: Value(DateTime.now())),
    );
  }

  Future<int> countOverdueUnpaid({int olderThanDays = 3}) async {
    final cutoff = DateTime.now().subtract(Duration(days: olderThanDays));
    final list = await (_db.select(_db.invoices)
          ..where((t) => t.status.isNotIn(['paid'])))
        .get();
    return list.where((i) => i.dateIssued.isBefore(cutoff)).length;
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.invoicePayments)
          ..where((t) => t.invoiceId.equals(id)))
        .go();
    await (_db.delete(_db.invoiceItems)..where((t) => t.invoiceId.equals(id)))
        .go();
    await (_db.delete(_db.invoices)..where((t) => t.id.equals(id))).go();
  }
}
