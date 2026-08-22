import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/booking/booking_form_screen.dart';
import '../features/booking/booking_list_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/invoice/invoice_detail_screen.dart';
import '../features/invoice/invoice_list_screen.dart';
import '../features/report/report_screen.dart';
import '../features/settings/export_data_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/shell/app_shell.dart';
import '../features/villa/villa_detail_screen.dart';
import '../features/villa/villa_form_screen.dart';
import '../features/villa/villa_list_screen.dart';

final _rootKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (_, __, shell) => AppShell(navigationShell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (_, __) => const DashboardScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/villas',
              builder: (_, __) => const VillaListScreen(),
              routes: [
                GoRoute(
                  path: 'new',
                  builder: (_, __) => const VillaFormScreen(),
                ),
                GoRoute(
                  path: ':id',
                  builder: (_, state) =>
                      VillaDetailScreen(villaId: state.pathParameters['id']!),
                  routes: [
                    GoRoute(
                      path: 'edit',
                      builder: (_, state) =>
                          VillaFormScreen(villaId: state.pathParameters['id']),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/bookings',
              builder: (_, __) => const BookingListScreen(),
              routes: [
                GoRoute(
                  path: 'new',
                  builder: (_, __) => const BookingFormScreen(),
                ),
                GoRoute(
                  path: ':id/edit',
                  builder: (_, state) =>
                      BookingFormScreen(bookingId: state.pathParameters['id']),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/invoices',
              builder: (_, __) => const InvoiceListScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (_, state) => InvoiceDetailScreen(
                    invoiceId: state.pathParameters['id']!,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootKey,
      path: '/reports',
      builder: (_, __) => const ReportScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootKey,
      path: '/settings',
      builder: (_, __) => const SettingsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootKey,
      path: '/settings/export',
      builder: (_, __) => const ExportDataScreen(),
    ),
  ],
);
