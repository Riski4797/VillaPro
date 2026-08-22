import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../invoice/invoice_providers.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overdue = ref.watch(overdueUnpaidCountProvider).valueOrNull ?? 0;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: const Border(
            top: BorderSide(color: AppColors.border, width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: NavigationBar(
          elevation: 0,
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.primary.withValues(alpha: 0.12),
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: navigationShell.goBranch,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard, color: AppColors.primary),
              label: 'Dashboard',
            ),
            const NavigationDestination(
              icon: Icon(Icons.villa_outlined),
              selectedIcon: Icon(Icons.villa, color: AppColors.primary),
              label: 'Villa',
            ),
            const NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(
                Icons.calendar_month,
                color: AppColors.primary,
              ),
              label: 'Booking',
            ),
            NavigationDestination(
              icon: Badge(
                backgroundColor: AppColors.gold,
                textColor: AppColors.textPrimary,
                isLabelVisible: overdue > 0,
                label: Text('$overdue'),
                child: const Icon(Icons.receipt_long_outlined),
              ),
              selectedIcon: Badge(
                backgroundColor: AppColors.gold,
                textColor: AppColors.textPrimary,
                isLabelVisible: overdue > 0,
                label: Text('$overdue'),
                child: const Icon(Icons.receipt_long, color: AppColors.primary),
              ),
              label: 'Invoice',
            ),
          ],
        ),
      ),
    );
  }
}
