import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:villa_manager/data/database/app_database.dart';
import 'package:villa_manager/data/database/dummy_data_seeder.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late Directory tempDir;

  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    tempDir = Directory.systemTemp.createTempSync('dummy_photos_test_');
  });

  tearDown(() {
    db.close();
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  test('DummyDataSeeder seeds villas, bookings, and invoices', () async {
    await DummyDataSeeder.seedIfEmpty(db, tempDir);

    final villas = await db.select(db.villas).get();
    expect(villas.length, 4);

    final bookings = await db.select(db.bookings).get();
    expect(bookings.length, 4);

    final invoices = await db.select(db.invoices).get();
    expect(invoices.length, 4);

    final payments = await db.select(db.invoicePayments).get();
    expect(payments.length, 4);

    final settings = await db.select(db.appSettings).get();
    expect(settings.first.businessName, 'Bali Sanctuary Villa Management');
  });
}
