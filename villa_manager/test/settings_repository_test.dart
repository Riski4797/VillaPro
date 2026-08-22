import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:villa_manager/data/database/app_database.dart';
import 'package:villa_manager/data/repositories/settings_repository.dart';

void main() {
  late AppDatabase db;
  late SettingsRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = SettingsRepository(db);
  });

  tearDown(() => db.close());

  test('getSettings returns default and can be updated', () async {
    var settings = await repo.getSettings();
    expect(settings.businessName, 'Villa Management & Reservations');

    await repo.updateSettings(
      businessName: 'Bali Sanctuary Villa Agency',
      tagline: 'LUXURY RETREATS & RESIDENCES',
      adminName: 'Riski Admin',
      adminContact: '6281299998888',
      bankAccounts: '• BCA: 555-123-9999 a.n. Bali Sanctuary',
      invoiceFooterNote: 'Wajib transfer DP 50% untuk mengunci tanggal.',
    );

    settings = await repo.getSettings();
    expect(settings.businessName, 'Bali Sanctuary Villa Agency');
    expect(settings.tagline, 'LUXURY RETREATS & RESIDENCES');
    expect(settings.adminName, 'Riski Admin');
    expect(settings.adminContact, '6281299998888');
    expect(settings.bankAccounts, contains('555-123-9999'));
    expect(settings.invoiceFooterNote, contains('DP 50%'));
  });
}
