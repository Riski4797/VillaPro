import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:villa_manager/data/database/app_database.dart';
import 'package:villa_manager/data/repositories/booking_repository.dart';
import 'package:villa_manager/data/repositories/invoice_repository.dart';
import 'package:villa_manager/data/repositories/settings_repository.dart';
import 'package:villa_manager/data/repositories/villa_repository.dart';
import 'package:villa_manager/services/export_service.dart';
import 'package:villa_manager/services/photo_storage_service.dart';

void main() {
  late Directory sourceDir;
  late Directory restoredDir;
  late AppDatabase sourceDb;
  late AppDatabase restoredDb;

  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  setUp(() {
    sourceDir = Directory.systemTemp.createTempSync('villapro_source_');
    restoredDir = Directory.systemTemp.createTempSync('villapro_restore_');
    sourceDb = AppDatabase(NativeDatabase.memory());
    restoredDb = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await sourceDb.close();
    await restoredDb.close();
    if (sourceDir.existsSync()) sourceDir.deleteSync(recursive: true);
    if (restoredDir.existsSync()) restoredDir.deleteSync(recursive: true);
  });

  test('encrypted backup restores all persisted state', () async {
    final villas = VillaRepository(sourceDb, PhotoStorageService(sourceDir));
    final villaId = await villas.upsert(
      name: 'Villa Backup',
      commissionPercent: 10,
    );
    final media = File('${sourceDir.path}/villa.jpg')
      ..writeAsBytesSync([1, 2, 3, 4]);
    await sourceDb
        .into(sourceDb.villaPhotos)
        .insert(
          VillaPhotosCompanion.insert(
            id: 'photo-1',
            villaId: villaId,
            filePath: media.path,
          ),
        );
    final logo = File('${sourceDir.path}/logo.png')
      ..writeAsBytesSync([5, 6, 7, 8]);
    await SettingsRepository(sourceDb).updateSettings(
      businessName: 'VillaPro Test',
      tagline: 'Test',
      adminName: 'Admin',
      adminContact: '0812',
      bankAccounts: 'BCA 123 a.n. Test',
      invoiceFooterNote: 'Footer',
      logoPath: logo.path,
    );
    final bookingId = await BookingRepository(sourceDb).upsert(
      villaId: villaId,
      guestName: 'Tamu Backup',
      guestContact: '0812',
      checkIn: DateTime(2026, 9, 1),
      checkOut: DateTime(2026, 9, 3),
      pricePerNightSnapshot: 1000000,
    );
    final booking = (await BookingRepository(sourceDb).getById(bookingId))!;
    final invoiceId = await InvoiceRepository(
      sourceDb,
    ).createFromBooking(booking: booking, villaName: 'Villa Backup');
    await InvoiceRepository(
      sourceDb,
    ).addPayment(invoiceId: invoiceId, amount: 500000);

    final backup = await ExportService(
      sourceDb,
      PhotoStorageService(sourceDir),
    ).buildZip('password-kuat');
    addTearDown(() async {
      if (await backup.exists()) await backup.delete();
    });

    await ExportService(
      restoredDb,
      PhotoStorageService(restoredDir),
    ).restore(backup, 'password-kuat');

    expect(await restoredDb.select(restoredDb.villas).get(), hasLength(1));
    expect(await restoredDb.select(restoredDb.bookings).get(), hasLength(1));
    expect(await restoredDb.select(restoredDb.invoices).get(), hasLength(1));
    expect(
      await restoredDb.select(restoredDb.invoicePayments).get(),
      hasLength(1),
    );
    final restoredPhoto = await restoredDb
        .select(restoredDb.villaPhotos)
        .getSingle();
    final restoredSettings = await restoredDb
        .select(restoredDb.appSettings)
        .getSingle();
    expect(File(restoredPhoto.filePath).existsSync(), isTrue);
    expect(restoredPhoto.mediaType, 'photo');
    expect(restoredSettings.bankAccounts, 'BCA 123 a.n. Test');
    expect(File(restoredSettings.logoPath).existsSync(), isTrue);
  });

  test('backup rejects weak password', () async {
    await expectLater(
      ExportService(sourceDb).buildZip('short'),
      throwsA(isA<ArgumentError>()),
    );
  });
}
