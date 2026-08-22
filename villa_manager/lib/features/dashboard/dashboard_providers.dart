import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/report_repository.dart';
import '../villa/villa_providers.dart';

final reportRepoProvider = Provider<ReportRepository>(
  (ref) => ReportRepository(ref.watch(databaseProvider)),
);

final dashboardProvider = FutureProvider<DashboardSnapshot>((ref) {
  // refresh when any core table stream updates would be nice; for now pull-to-refresh
  return ref.watch(reportRepoProvider).dashboard();
});
