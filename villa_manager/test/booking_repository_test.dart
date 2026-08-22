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

  test('watchAll emits properly', () async {
    final villaId = await villaRepo.upsert(name: 'Villa Bali');
    await bookingRepo.upsert(
      villaId: villaId,
      guestName: 'Budi',
      guestContact: '0812345',
      checkIn: DateTime(2026, 8, 20),
      checkOut: DateTime(2026, 8, 25),
      pricePerNightSnapshot: 1000000,
    );

    final list = await bookingRepo.watchAll().first;
    expect(list.length, 1);
    expect(list.first.villaName, 'Villa Bali');
    expect(list.first.booking.guestName, 'Budi');
  });
}
