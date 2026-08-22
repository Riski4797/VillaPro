import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/report_repository.dart';
import '../booking/booking_providers.dart';
import '../villa/villa_providers.dart';

final reportRepoProvider = Provider<ReportRepository>(
  (ref) => ReportRepository(ref.watch(databaseProvider)),
);

final dashboardProvider = StreamProvider<DashboardSnapshot>((ref) {
  ref.watch(todayProvider);
  return ref.watch(reportRepoProvider).watchDashboard();
});
