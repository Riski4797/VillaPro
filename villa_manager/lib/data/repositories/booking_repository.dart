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
      leftOuterJoin(
          _db.villas, _db.villas.id.equalsExp(_db.bookings.villaId)),
    ])
      ..orderBy([OrderingTerm.desc(_db.bookings.checkIn)]);
    return q.watch().map((rows) => rows
        .map((r) => BookingWithVilla(
              r.readTable(_db.bookings),
              r.readTableOrNull(_db.villas)?.name ?? '—',
            ))
        .toList());
  }

  Future<Booking?> getById(String id) =>
      (_db.select(_db.bookings)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Stream<VillaOccupancyStatus> watchOccupancyStatus(String villaId) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return (_db.select(_db.bookings)
          ..where((b) =>
              b.villaId.equals(villaId) &
              b.status.equals('confirmed') &
              b.checkOut.isBiggerThanValue(today))
          ..orderBy([(b) => OrderingTerm.asc(b.checkIn)]))
        .watch()
        .map((list) {
      Booking? current;
      Booking? next;
      for (final b in list) {
        final cin = DateTime(b.checkIn.year, b.checkIn.month, b.checkIn.day);
        final cout =
            DateTime(b.checkOut.year, b.checkOut.month, b.checkOut.day);
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
    final rows = await (_db.select(_db.bookings)
          ..where((t) =>
              t.villaId.equals(villaId) & t.status.equals('confirmed')))
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
  }) async {
    final now = DateTime.now();
    final String bookingId;
    if (id == null) {
      bookingId = _uuid.v4();
      await _db.into(_db.bookings).insert(BookingsCompanion.insert(
            id: bookingId,
            villaId: villaId,
            guestName: guestName,
            guestContact: Value(normalizeWa(guestContact)),
            checkIn: checkIn,
            checkOut: checkOut,
            pricePerNightSnapshot: Value(pricePerNightSnapshot),
            status: Value(status),
            notes: Value(notes),
            createdAt: now,
          ));
    } else {
      bookingId = id;
      await (_db.update(_db.bookings)..where((t) => t.id.equals(id))).write(
        BookingsCompanion(
          villaId: Value(villaId),
          guestName: Value(guestName),
          guestContact: Value(normalizeWa(guestContact)),
          checkIn: Value(checkIn),
          checkOut: Value(checkOut),
          pricePerNightSnapshot: Value(pricePerNightSnapshot),
          status: Value(status),
          notes: Value(notes),
        ),
      );
    }

    final villa = await (_db.select(_db.villas)
          ..where((t) => t.id.equals(villaId)))
        .getSingleOrNull();
    await NotificationService.instance.scheduleCheckIn(
      bookingId: bookingId,
      guestName: guestName,
      villaName: villa?.name ?? 'villa',
      checkIn: checkIn,
      status: status,
    );
    return bookingId;
  }

  Future<void> setStatus(String id, String status) async {
    await (_db.update(_db.bookings)..where((t) => t.id.equals(id)))
        .write(BookingsCompanion(status: Value(status)));
    final b = await getById(id);
    if (b == null) return;
    final villa = await (_db.select(_db.villas)
          ..where((t) => t.id.equals(b.villaId)))
        .getSingleOrNull();
    await NotificationService.instance.scheduleCheckIn(
      bookingId: id,
      guestName: b.guestName,
      villaName: villa?.name ?? 'villa',
      checkIn: b.checkIn,
      status: status,
    );
  }

  Future<void> delete(String id) async {
    await NotificationService.instance.cancelCheckIn(id);
    await (_db.delete(_db.bookings)..where((t) => t.id.equals(id))).go();
  }
}
