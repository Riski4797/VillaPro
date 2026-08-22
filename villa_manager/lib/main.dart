import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/router.dart';
import 'core/theme/app_theme.dart';
import 'data/database/dummy_data_seeder.dart';
import 'features/invoice/invoice_providers.dart';
import 'features/villa/villa_providers.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID');
  await NotificationService.instance.init();
  runApp(const ProviderScope(child: VillaManagerApp()));
}

class VillaManagerApp extends ConsumerStatefulWidget {
  const VillaManagerApp({super.key});

  @override
  ConsumerState<VillaManagerApp> createState() => _VillaManagerAppState();
}

class _VillaManagerAppState extends ConsumerState<VillaManagerApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        // ONLY auto-seed dummy data when running in debug mode on Linux (local desktop testing)
        // Never auto-seed on Android / Release builds so user data is never overwritten.
        if (kDebugMode && !kIsWeb && Platform.isLinux) {
          final db = ref.read(databaseProvider);
          await DummyDataSeeder.seedIfEmpty(db);
        }

        await NotificationService.instance
            .checkUnpaidInvoices(ref.read(invoiceRepoProvider));
      } catch (e) {
        debugPrint('App init error: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Villa Manager',
      theme: appTheme(),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
