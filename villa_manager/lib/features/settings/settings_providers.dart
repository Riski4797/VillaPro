import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../data/repositories/settings_repository.dart';
import '../villa/villa_providers.dart';

final settingsRepoProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(databaseProvider)),
);

final appSettingsProvider = StreamProvider<AppSetting>((ref) {
  return ref.watch(settingsRepoProvider).watchSettings();
});
