import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:villa_manager/data/database/app_database.dart';
import 'package:villa_manager/data/repositories/booking_repository.dart';
import 'package:villa_manager/data/repositories/invoice_repository.dart';
import 'package:villa_manager/data/repositories/villa_repository.dart';

void main() {
  late AppDatabase db;
  late InvoiceRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = InvoiceRepository(db);
  });

  tearDown(() => db.close());

  test('invoice with down payment (DP) and full settlement', () async {
    final now = DateTime.now();
    final villaId = await VillaRepository(
      db,
    ).upsert(name: 'Villa Sunset', commissionPercent: 10);
    final bookingId = await BookingRepository(db).upsert(
      villaId: villaId,
      guestName: 'Budi Santoso',
      guestContact: '628123456789',
      checkIn: now,
      checkOut: now.add(const Duration(days: 3)),
      pricePerNightSnapshot: 1000000,
    );
    final booking = (await BookingRepository(db).getById(bookingId))!;

    final invId = await repo.createFromBooking(
      booking: booking,
      villaName: 'Villa Sunset',
    );

    // Initial total is 3 nights * 1.000.000 = 3.000.000, status unpaid
    var detail = await repo.getDetail(invId);
    expect(detail, isNotNull);
    expect(detail!.total, 3000000);
    expect(detail.paidAmount, 0);
    expect(detail.remainingBalance, 3000000);
    expect(detail.effectiveStatus, 'unpaid');

    // Add Down Payment (DP) 50% = 1.500.000
    await repo.addPayment(
      invoiceId: invId,
      amount: 1500000,
      paymentMethod: 'Transfer Bank',
      notes: 'DP 50%',
    );

    detail = await repo.getDetail(invId);
    expect(detail!.total, 3000000);
    expect(detail.paidAmount, 1500000);
    expect(detail.remainingBalance, 1500000);
    expect(detail.effectiveStatus, 'partial');
    expect(detail.statusLabel, 'DP DITERIMA');

    // Add Final Payment = 1.500.000
    await repo.addPayment(
      invoiceId: invId,
      amount: 1500000,
      paymentMethod: 'Cash',
      notes: 'Pelunasan check-in',
    );

    detail = await repo.getDetail(invId);
    expect(detail!.total, 3000000);
    expect(detail.paidAmount, 3000000);
    expect(detail.remainingBalance, 0);
    expect(detail.effectiveStatus, 'paid');
    expect(detail.statusLabel, 'LUNAS');
  });
}
