import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/booking_utils.dart';
import '../../services/notification_service.dart';
import '../database/app_database.dart';

class BookingWithVilla {
  BookingWithVilla(this.booking, this.villaName);
  final Booking booking;
  final String villaName;

  int get total =>
      booking.pricePerNightSnapshot *
      nightsBetween(booking.checkIn, booking.checkOut);
}

class VillaOccupancyStatus {
  const VillaOccupancyStatus({
    required this.isOccupiedToday,
    this.currentBooking,
    this.nextBooking,
  });

  final bool isOccupiedToday;
  final Booking? currentBooking;
  final Booking? nextBooking;
}

class BookingRepository {
  BookingRepository(this._db);
  final AppDatabase _db;
  static const _uuid = Uuid();

  Stream<List<BookingWithVilla>> watchAll() {
    final q = _db.select(_db.bookings).join([
      leftOuterJoin(_db.villas, _db.villas.id.equalsExp(_db.bookings.villaId)),
    ])..orderBy([OrderingTerm.desc(_db.bookings.checkIn)]);
    return q.watch().map(
      (rows) => rows
          .map(
            (r) => BookingWithVilla(
              r.readTable(_db.bookings),
              r.readTableOrNull(_db.villas)?.name ?? '—',
            ),
          )
          .toList(),
    );
  }

  Future<Booking?> getById(String id) => (_db.select(
    _db.bookings,
  )..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<VillaOccupancyStatus> watchOccupancyStatus(
    String villaId, {
    DateTime? onDate,
  }) {
    final date = onDate ?? DateTime.now();
    final today = DateTime(date.year, date.month, date.day);

    return (_db.select(_db.bookings)
          ..where(
            (b) =>
                b.villaId.equals(villaId) &
                b.status.equals('confirmed') &
                b.checkOut.isBiggerThanValue(today),
          )
          ..orderBy([(b) => OrderingTerm.asc(b.checkIn)]))
        .watch()
        .map((list) {
          Booking? current;
          Booking? next;
          for (final b in list) {
            final cin = DateTime(
              b.checkIn.year,
              b.checkIn.month,
              b.checkIn.day,
            );
            final cout = DateTime(
              b.checkOut.year,
              b.checkOut.month,
              b.checkOut.day,
            );
            if (!cin.isAfter(today) && cout.isAfter(today)) {
              current = b;
            } else if (cin.isAfter(today) && next == null) {
              next = b;
            }
          }
          return VillaOccupancyStatus(
            isOccupiedToday: current != null,
            currentBooking: current,
            nextBooking: next,
          );
        });
  }

  Future<List<Booking>> findOverlaps({
    required String villaId,
    required DateTime checkIn,
    required DateTime checkOut,
    String? excludeId,
  }) async {
    final rows =
        await (_db.select(_db.bookings)..where(
              (t) => t.villaId.equals(villaId) & t.status.equals('confirmed'),
            ))
            .get();
    return rows.where((b) {
      if (excludeId != null && b.id == excludeId) return false;
      return dateRangeOverlap(checkIn, checkOut, b.checkIn, b.checkOut);
    }).toList();
  }

  Future<String> upsert({
    String? id,
    required String villaId,
    required String guestName,
    required String guestContact,
    required DateTime checkIn,
    required DateTime checkOut,
    required int pricePerNightSnapshot,
    String status = 'confirmed',
    String notes = '',
    bool allowOverlap = false,
  }) async {
    if (guestName.trim().isEmpty) {
      throw ArgumentError.value(guestName, 'guestName', 'Wajib diisi');
    }
    final normalizedCheckIn = DateTime(
      checkIn.year,
      checkIn.month,
      checkIn.day,
    );
    final normalizedCheckOut = DateTime(
      checkOut.year,
      checkOut.month,
      checkOut.day,
    );
    if (!normalizedCheckOut.isAfter(normalizedCheckIn)) {
      throw ArgumentError('Check-out harus setelah check-in');
    }
    if (pricePerNightSnapshot < 0) {
      throw ArgumentError.value(
        pricePerNightSnapshot,
        'pricePerNightSnapshot',
        'Tidak boleh negatif',
      );
    }
    if (!const {'confirmed', 'cancelled'}.contains(status)) {
      throw ArgumentError.value(status, 'status', 'Status tidak valid');
    }

    final now = DateTime.now();
    late final Villa villa;
    final bookingId = await _db.transaction(() async {
      final selectedVilla = await (_db.select(
        _db.villas,
      )..where((t) => t.id.equals(villaId))).getSingleOrNull();
      if (selectedVilla == null) throw StateError('Villa tidak ditemukan');
      villa = selectedVilla;

      final existing = id == null ? null : await getById(id);
      if (id != null && existing == null) {
        throw StateError('Booking tidak ditemukan');
      }
      final existingInvoice = id == null
          ? null
          : await (_db.select(_db.invoices)
                  ..where((invoice) => invoice.bookingId.equals(id)))
                .getSingleOrNull();
      if (existingInvoice != null &&
          (existing!.villaId != villaId ||
              existing.guestName != guestName.trim() ||
              existing.guestContact != normalizeWa(guestContact) ||
              existing.checkIn != normalizedCheckIn ||
              existing.checkOut != normalizedCheckOut ||
              existing.pricePerNightSnapshot != pricePerNightSnapshot ||
              existing.status != status)) {
        throw StateError(
          'Booking yang sudah memiliki invoice tidak dapat diubah pada data komersial',
        );
      }

      if (status == 'confirmed' && !allowOverlap) {
        final overlaps = await findOverlaps(
          villaId: villaId,
          checkIn: normalizedCheckIn,
          checkOut: normalizedCheckOut,
          excludeId: id,
        );
        if (overlaps.isNotEmpty) throw StateError('Tanggal booking bentrok');
      }

      final companion = BookingsCompanion(
        villaId: Value(villaId),
        guestName: Value(guestName.trim()),
        guestContact: Value(normalizeWa(guestContact)),
        checkIn: Value(normalizedCheckIn),
        checkOut: Value(normalizedCheckOut),
        pricePerNightSnapshot: Value(pricePerNightSnapshot),
        commissionTypeSnapshot: Value(
          existingInvoice == null
              ? villa.commissionType
              : existing!.commissionTypeSnapshot,
        ),
        commissionPercentSnapshot: Value(
          existingInvoice == null
              ? villa.commissionPercent
              : existing!.commissionPercentSnapshot,
        ),
        commissionFixedSnapshot: Value(
          existingInvoice == null
              ? villa.commissionFixed
              : existing!.commissionFixedSnapshot,
        ),
        status: Value(status),
        notes: Value(notes.trim()),
      );

      if (id == null) {
        final newId = _uuid.v4();
        await _db
            .into(_db.bookings)
            .insert(
              companion.copyWith(id: Value(newId), createdAt: Value(now)),
            );
        return newId;
      }

      final updated = await (_db.update(
        _db.bookings,
      )..where((t) => t.id.equals(id))).write(companion);
      if (updated != 1) throw StateError('Booking tidak ditemukan');
      return id;
    });

    await NotificationService.instance.scheduleCheckIn(
      bookingId: bookingId,
      guestName: guestName.trim(),
      villaName: villa.name,
      checkIn: normalizedCheckIn,
      status: status,
    );
    return bookingId;
  }

  Future<void> delete(String id) async {
    final deleted = await (_db.delete(
      _db.bookings,
    )..where((t) => t.id.equals(id))).go();
    if (deleted != 1) throw StateError('Booking tidak ditemukan');
    await NotificationService.instance.cancelCheckIn(id);
  }
}
