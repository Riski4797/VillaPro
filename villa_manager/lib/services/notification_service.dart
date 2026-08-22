import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../data/database/app_database.dart';
import '../data/repositories/invoice_repository.dart';

class NotificationService {
  NotificationService._();
  static final instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  Future<void> init() async {
    if (_ready) return;
    try {
      tzdata.initializeTimeZones();
      try {
        tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
      } catch (_) {
        tz.setLocalLocation(tz.local);
      }

      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      await _plugin.initialize(
        settings: const InitializationSettings(
          android: android,
          linux: LinuxInitializationSettings(defaultActionName: 'Open'),
        ),
      );

      final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.requestNotificationsPermission();

      _ready = true;
    } catch (e) {
      debugPrint('NotificationService init error (ignored): $e');
    }
  }

  int _idFromBooking(String bookingId) =>
      bookingId.hashCode & 0x7fffffff; // positive 31-bit

  Future<void> cancelCheckIn(String bookingId) async {
    try {
      if (!_ready) await init();
      await _plugin.cancel(id: _idFromBooking(bookingId));
    } catch (e) {
      debugPrint('cancelCheckIn error: $e');
    }
  }

  /// Schedule H-1 at 09:00 local. No-op if time already passed or cancelled.
  Future<void> scheduleCheckIn({
    required String bookingId,
    required String guestName,
    required String villaName,
    required DateTime checkIn,
    required String status,
  }) async {
    try {
      if (!_ready) await init();
      await cancelCheckIn(bookingId);
      if (status != 'confirmed') return;

      final dayBefore = DateTime(checkIn.year, checkIn.month, checkIn.day)
          .subtract(const Duration(days: 1));
      final when = tz.TZDateTime(
        tz.local,
        dayBefore.year,
        dayBefore.month,
        dayBefore.day,
        9,
      );
      if (when.isBefore(tz.TZDateTime.now(tz.local))) return;

      await _plugin.zonedSchedule(
        id: _idFromBooking(bookingId),
        title: 'Check-in besok',
        body: 'Besok check-in: $guestName di $villaName',
        scheduledDate: when,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'checkin_h1',
            'Reminder check-in',
            channelDescription: 'Pengingat H-1 sebelum check-in',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    } catch (e) {
      debugPrint('scheduleCheckIn error: $e');
    }
  }

  Future<void> showUnpaidReminder(Invoice invoice) async {
    try {
      if (!_ready) await init();
      final id = (invoice.id.hashCode & 0x7fffffff) ^ 0x10000000;
      await _plugin.show(
        id: id,
        title: 'Invoice belum dibayar',
        body:
            '${invoice.invoiceNumber} · ${invoice.guestName} · ${invoice.villaName}',
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'invoice_unpaid',
            'Invoice tunggakan',
            channelDescription: 'Reminder invoice belum lunas >3 hari',
            importance: Importance.defaultImportance,
          ),
        ),
      );
    } catch (e) {
      debugPrint('showUnpaidReminder error: $e');
    }
  }

  /// Scan unpaid invoices older than 3 days; notify + stamp reminderSentAt.
  Future<int> checkUnpaidInvoices(InvoiceRepository repo) async {
    try {
      if (!_ready) await init();
      if (kIsWeb) return 0;

      final list = await repo.watchAll().first;
      final now = DateTime.now();
      final cutoff = now.subtract(const Duration(days: 3));
      var n = 0;
      for (final row in list) {
        final inv = row.invoice;
        if (inv.status != 'unpaid') continue;
        if (!inv.dateIssued.isBefore(cutoff)) continue;
        final sent = inv.reminderSentAt;
        if (sent != null && !sent.isBefore(cutoff)) continue;
        await showUnpaidReminder(inv);
        await repo.markReminderSent(inv.id);
        n++;
      }
      return n;
    } catch (e) {
      debugPrint('checkUnpaidInvoices error: $e');
      return 0;
    }
  }
}
