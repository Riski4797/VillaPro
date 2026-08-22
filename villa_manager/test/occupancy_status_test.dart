import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:villa_manager/data/database/app_database.dart';
import 'package:villa_manager/data/repositories/booking_repository.dart';
import 'package:villa_manager/data/repositories/villa_repository.dart';

void main() {
  late AppDatabase db;
  late VillaRepository villaRepo;
  late BookingRepository bookingRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    villaRepo = VillaRepository(db);
    bookingRepo = BookingRepository(db);
  });

  tearDown(() => db.close());

  test('watchOccupancyStatus detects occupied vs available correctly',
      () async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final villaId = await villaRepo.upsert(name: 'Villa Kupu');

    // Initially available
    var status = await bookingRepo.watchOccupancyStatus(villaId).first;
    expect(status.isOccupiedToday, false);

    // Booked for today
    await bookingRepo.upsert(
      villaId: villaId,
      guestName: 'Andi',
      guestContact: '0811111',
      checkIn: today.subtract(const Duration(days: 1)),
      checkOut: today.add(const Duration(days: 2)),
      pricePerNightSnapshot: 1500000,
    );

    status = await bookingRepo.watchOccupancyStatus(villaId).first;
    expect(status.isOccupiedToday, true);
    expect(status.currentBooking?.guestName, 'Andi');
  });
}
