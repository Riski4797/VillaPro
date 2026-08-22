import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:villa_manager/data/database/app_database.dart';
import 'package:villa_manager/data/repositories/booking_repository.dart';
import 'package:villa_manager/data/repositories/invoice_repository.dart';
import 'package:villa_manager/data/repositories/report_repository.dart';
import 'package:villa_manager/data/repositories/villa_repository.dart';

void main() {
  late AppDatabase db;
  late VillaRepository villas;
  late BookingRepository bookings;
  late InvoiceRepository invoices;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    villas = VillaRepository(db);
    bookings = BookingRepository(db);
    invoices = InvoiceRepository(db);
  });

  tearDown(() => db.close());

  Future<(String, String, String)> createInvoice({
    int nightlyRate = 1000000,
    double commission = 10,
  }) async {
    final villaId = await villas.upsert(
      name: 'Villa Integritas',
      commissionPercent: commission,
    );
    final bookingId = await bookings.upsert(
      villaId: villaId,
      guestName: 'Tamu Integritas',
      guestContact: '08123456789',
      checkIn: DateTime(2026, 8, 10),
      checkOut: DateTime(2026, 8, 12),
      pricePerNightSnapshot: nightlyRate,
    );
    final booking = (await bookings.getById(bookingId))!;
    final invoiceId = await invoices.createFromBooking(
      booking: booking,
      villaName: 'Villa Integritas',
    );
    return (villaId, bookingId, invoiceId);
  }

  test('partial invoice remains in outstanding dashboard balance', () async {
    final (_, _, invoiceId) = await createInvoice();
    await invoices.addPayment(invoiceId: invoiceId, amount: 500000);

    final dashboard = await ReportRepository(db).dashboard();
    expect(dashboard.unpaidCount, 1);
    expect(dashboard.unpaidTotal, 1500000);
  });

  test('invoice list reacts to payment totals', () async {
    final (_, _, invoiceId) = await createInvoice();
    final initial = Completer<void>();
    final updated = Completer<void>();
    final activeSubscription = invoices.watchAll().listen((rows) {
      if (rows.length != 1) return;
      final row = rows.single;
      if (row.total == 2000000 && row.paidAmount == 0) {
        if (!initial.isCompleted) initial.complete();
      }
      if (row.paidAmount == 500000 && !updated.isCompleted) {
        updated.complete();
      }
    });
    addTearDown(activeSubscription.cancel);

    await initial.future.timeout(const Duration(seconds: 5));
    await invoices.addPayment(invoiceId: invoiceId, amount: 500000);
    await updated.future.timeout(const Duration(seconds: 5));
  });

  test('dashboard returns upcoming check-ins from joined query', () async {
    final villaId = await villas.upsert(name: 'Villa Mendatang');
    final today = DateTime.now();
    final checkIn = DateTime(
      today.year,
      today.month,
      today.day,
    ).add(const Duration(days: 2));
    await bookings.upsert(
      villaId: villaId,
      guestName: 'Tamu Mendatang',
      guestContact: '08123456789',
      checkIn: checkIn,
      checkOut: checkIn.add(const Duration(days: 2)),
      pricePerNightSnapshot: 1000000,
    );

    final dashboard = await ReportRepository(db).dashboard();
    expect(dashboard.upcomingCheckIns, hasLength(1));
    expect(dashboard.upcomingCheckIns.single.villaName, 'Villa Mendatang');
    expect(dashboard.upcomingCheckIns.single.checkIn, checkIn);
  });

  test('rejects overpayment and supports balances above one billion', () async {
    final (_, _, invoiceId) = await createInvoice(nightlyRate: 1000000000);
    final detail = (await invoices.getDetail(invoiceId))!;
    expect(detail.remainingBalance, 2000000000);

    await expectLater(
      invoices.addPayment(invoiceId: invoiceId, amount: 2000000001),
      throwsA(isA<ArgumentError>()),
    );
  });

  test('invoice creation is idempotent and commission is historical', () async {
    final (villaId, bookingId, invoiceId) = await createInvoice();
    final booking = (await bookings.getById(bookingId))!;
    final duplicate = await invoices.createFromBooking(
      booking: booking,
      villaName: 'Villa Integritas',
    );
    expect(duplicate, invoiceId);
    expect(await db.select(db.invoices).get(), hasLength(1));

    await invoices.addPayment(
      invoiceId: invoiceId,
      amount: 2000000,
      datePaid: DateTime(2026, 8, 15),
    );
    await villas.upsert(
      id: villaId,
      name: 'Villa Integritas',
      commissionPercent: 50,
    );
    final report = await ReportRepository(
      db,
    ).summary(DateTime(2026, 8, 1), DateTime(2026, 8, 31));
    expect(report.komisi, 200000);
  });

  test('referenced booking and villa cannot be deleted', () async {
    final (villaId, bookingId, _) = await createInvoice();
    await expectLater(bookings.delete(bookingId), throwsA(anything));
    await expectLater(villas.delete(villaId), throwsA(isA<StateError>()));
  });
}
