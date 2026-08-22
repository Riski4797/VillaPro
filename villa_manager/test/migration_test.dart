import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:villa_manager/data/database/app_database.dart';

import 'generated_migrations/schema.dart';
import 'generated_migrations/schema_v1.dart' as v1;
import 'generated_migrations/schema_v9.dart' as v9;
import 'generated_migrations/schema_v10.dart' as v10;

void main() {
  final verifier = SchemaVerifier(GeneratedHelper());

  test('migrates directly from v1 to v10', () async {
    final schema = await verifier.schemaAt(1);
    final oldDb = v1.DatabaseAtV1(schema.newConnection());
    final now = DateTime(2026, 8, 22).millisecondsSinceEpoch ~/ 1000;
    await oldDb
        .into(oldDb.villas)
        .insert(
          v1.VillasCompanion.insert(
            id: 'villa-v1',
            name: 'Villa Lama',
            commissionPercent: const Value(10),
            createdAt: now,
            updatedAt: now,
          ),
        );
    await oldDb.close();

    final migratedDb = AppDatabase(schema.newConnection());
    await verifier.migrateAndValidate(migratedDb, 10);
    await migratedDb.close();

    final checkDb = v10.DatabaseAtV10(schema.newConnection());
    final villa = await checkDb.select(checkDb.villas).getSingle();
    expect(villa.name, 'Villa Lama');
    expect(villa.commissionPercent, 10);
    await checkDb.close();
    schema.close();
  });

  for (var version = 2; version <= 8; version++) {
    test('migrates directly from v$version to v10', () async {
      final schema = await verifier.schemaAt(version);
      final migratedDb = AppDatabase(schema.newConnection());
      await verifier.migrateAndValidate(migratedDb, 10);
      await migratedDb.close();
      schema.close();
    });
  }

  test('migrates v9 data to v10 with constraints and snapshots', () async {
    final schema = await verifier.schemaAt(9);
    final oldDb = v9.DatabaseAtV9(schema.newConnection());
    final checkIn = DateTime(2026, 8, 22);
    final checkOut = DateTime(2026, 8, 24);
    final now = checkIn.millisecondsSinceEpoch ~/ 1000;

    await oldDb
        .into(oldDb.villas)
        .insert(
          v9.VillasCompanion.insert(
            id: 'villa-1',
            name: 'Villa Test',
            commissionType: const Value('percent'),
            commissionPercent: const Value(12.5),
            createdAt: now,
            updatedAt: now,
          ),
        );
    await oldDb
        .into(oldDb.bookings)
        .insert(
          v9.BookingsCompanion.insert(
            id: 'booking-1',
            villaId: 'villa-1',
            guestName: 'Tamu Test',
            checkIn: checkIn.millisecondsSinceEpoch ~/ 1000,
            checkOut: checkOut.millisecondsSinceEpoch ~/ 1000,
            pricePerNightSnapshot: const Value(1000000),
            createdAt: now,
          ),
        );
    await oldDb
        .into(oldDb.invoices)
        .insert(
          v9.InvoicesCompanion.insert(
            id: 'invoice-1',
            invoiceNumber: 'INV-202608-001',
            bookingId: 'booking-1',
            guestName: 'Tamu Test',
            villaName: 'Villa Test',
            checkIn: checkIn.millisecondsSinceEpoch ~/ 1000,
            checkOut: checkOut.millisecondsSinceEpoch ~/ 1000,
            dateIssued: now,
          ),
        );
    await oldDb
        .into(oldDb.appSettings)
        .insert(
          v9.AppSettingsCompanion.insert(
            bankAccounts: const Value(
              '- BCA: 123-456-7890 a.n. Villa Manager\n'
              '- Mandiri: 987-654-3210 a.n. Villa Manager',
            ),
          ),
        );
    await oldDb.close();

    final migratedDb = AppDatabase(schema.newConnection());
    await verifier.migrateAndValidate(migratedDb, 10);
    await migratedDb.close();

    final checkDb = v10.DatabaseAtV10(schema.newConnection());
    final booking = await checkDb.select(checkDb.bookings).getSingle();
    final invoice = await checkDb.select(checkDb.invoices).getSingle();
    final settings = await checkDb.select(checkDb.appSettings).getSingle();

    expect(booking.commissionTypeSnapshot, 'percent');
    expect(booking.commissionPercentSnapshot, 12.5);
    expect(booking.checkIn, now);
    expect(booking.checkOut, checkOut.millisecondsSinceEpoch ~/ 1000);
    expect(invoice.commissionPercentSnapshot, 12.5);
    expect(settings.bankAccounts, isEmpty);
    await checkDb.close();
    schema.close();
  });

  test('repairs legacy rows before applying v10 constraints', () async {
    final schema = await verifier.schemaAt(9);
    final oldDb = v9.DatabaseAtV9(schema.newConnection());
    final checkIn = DateTime(2026, 8, 22);
    final rawCheckIn = checkIn.millisecondsSinceEpoch ~/ 1000;

    await oldDb.customStatement(
      '''
      INSERT INTO villas (
        id, name, price_weekday, commission_percent, commission_type,
        commission_fixed, created_at, updated_at
      ) VALUES ('legacy-bad', 'Legacy Bad', -100, 250, 'unknown', -5, ?, ?)
    ''',
      [rawCheckIn, rawCheckIn],
    );
    await oldDb.customStatement('''
      INSERT INTO villa_photos (id, villa_id, file_path, media_type, sort_order)
      VALUES ('photo-bad', 'legacy-bad', '/tmp/photo.jpg', 'unknown', -1)
    ''');
    await oldDb.customStatement(
      '''
      INSERT INTO bookings (
        id, villa_id, guest_name, check_in, check_out,
        price_per_night_snapshot, status, created_at
      ) VALUES ('booking-bad', 'legacy-bad', 'Legacy Guest', ?, ?, -10, 'unknown', ?)
    ''',
      [rawCheckIn, rawCheckIn, rawCheckIn],
    );
    await oldDb.customStatement(
      '''
      INSERT INTO invoices (
        id, invoice_number, booking_id, guest_name, villa_name,
        check_in, check_out, status, date_issued
      ) VALUES ('invoice-bad', 'LEGACY-BAD', 'booking-bad', 'Legacy Guest',
        'Legacy Bad', ?, ?, 'unknown', ?)
    ''',
      [rawCheckIn, rawCheckIn, rawCheckIn],
    );
    await oldDb.customStatement('''
      INSERT INTO invoice_items (id, invoice_id, description, qty, price)
      VALUES ('item-bad', 'invoice-bad', 'Legacy item', 0, -1)
    ''');
    await oldDb.customStatement(
      '''
      INSERT INTO invoice_payments (
        id, invoice_id, amount, date_paid, payment_method, notes
      ) VALUES ('payment-bad', 'invoice-bad', 0, ?, 'Transfer Bank', '')
    ''',
      [rawCheckIn],
    );
    await oldDb.close();

    final migratedDb = AppDatabase(schema.newConnection());
    await verifier.migrateAndValidate(migratedDb, 10);
    await migratedDb.close();

    final checkDb = v10.DatabaseAtV10(schema.newConnection());
    final villa = await checkDb.select(checkDb.villas).getSingle();
    final photo = await checkDb.select(checkDb.villaPhotos).getSingle();
    final booking = await checkDb.select(checkDb.bookings).getSingle();
    final invoice = await checkDb.select(checkDb.invoices).getSingle();
    final item = await checkDb.select(checkDb.invoiceItems).getSingle();

    expect(villa.priceWeekday, 0);
    expect(villa.commissionPercent, 100);
    expect(villa.commissionType, 'percent');
    expect(villa.commissionFixed, 0);
    expect(photo.mediaType, 'photo');
    expect(photo.sortOrder, 0);
    expect(booking.checkOut, rawCheckIn + 86400);
    expect(booking.pricePerNightSnapshot, 0);
    expect(booking.status, 'confirmed');
    expect(invoice.status, 'unpaid');
    expect(item.qty, 1);
    expect(item.price, 0);
    expect(await checkDb.select(checkDb.invoicePayments).get(), isEmpty);
    await checkDb.close();
    schema.close();
  });
}
