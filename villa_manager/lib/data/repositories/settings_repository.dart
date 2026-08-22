import 'package:drift/drift.dart';

import '../database/app_database.dart';

class SettingsRepository {
  SettingsRepository(this._db);
  final AppDatabase _db;

  static const defaultId = 'default';

  Future<AppSetting> getSettings() async {
    final existing = await (_db.select(_db.appSettings)
          ..where((t) => t.id.equals(defaultId)))
        .getSingleOrNull();
    if (existing != null) return existing;

    // Seed default if not exists
    await _db.into(_db.appSettings).insert(
          const AppSettingsCompanion(id: Value(defaultId)),
          mode: InsertMode.insertOrIgnore,
        );
    return (_db.select(_db.appSettings)..where((t) => t.id.equals(defaultId)))
        .getSingle();
  }

  Stream<AppSetting> watchSettings() {
    return (_db.select(_db.appSettings)..where((t) => t.id.equals(defaultId)))
        .watchSingleOrNull()
        .asyncMap((setting) async {
      if (setting != null) return setting;
      return getSettings();
    });
  }

  Future<void> updateSettings({
    required String businessName,
    required String tagline,
    required String adminName,
    required String adminContact,
    required String bankAccounts,
    required String invoiceFooterNote,
    String? logoPath,
    String? templateTeaser,
    String? templateDetail,
    String? templateButlerNotification,
  }) async {
    await _db.into(_db.appSettings).insertOnConflictUpdate(
          AppSettingsCompanion(
            id: const Value(defaultId),
            businessName: Value(businessName),
            tagline: Value(tagline),
            logoPath: logoPath != null
                ? Value(logoPath)
                : const Value.absent(),
            adminName: Value(adminName),
            adminContact: Value(adminContact),
            bankAccounts: Value(bankAccounts),
            invoiceFooterNote: Value(invoiceFooterNote),
            templateTeaser: templateTeaser != null
                ? Value(templateTeaser)
                : const Value.absent(),
            templateDetail: templateDetail != null
                ? Value(templateDetail)
                : const Value.absent(),
            templateButlerNotification: templateButlerNotification != null
                ? Value(templateButlerNotification)
                : const Value.absent(),
          ),
        );
  }
}
