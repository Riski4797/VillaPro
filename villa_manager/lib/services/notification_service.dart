import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
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
      if (!kIsWeb && Platform.isLinux) {
        _ready = true;
        return;
      }
      try {
        final timezone = await FlutterTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(timezone.identifier));
      } catch (_) {
        tz.setLocalLocation(tz.getLocation('Asia/Makassar'));
      }

      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      await _plugin.initialize(
        settings: const InitializationSettings(
          android: android,
          linux: LinuxInitializationSettings(defaultActionName: 'Open'),
        ),
      );

      _ready = true;
    } catch (e) {
      debugPrint('NotificationService init error (ignored): $e');
    }
  }

  int _idFromBooking(String bookingId) {
    var hash = 0x811c9dc5;
    for (final byte in bookingId.codeUnits) {
      hash = ((hash ^ byte) * 0x01000193) & 0xffffffff;
    }
    return hash & 0x7fffffff;
  }

  Future<bool> _ensurePermission() async {
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    return await androidPlugin?.requestNotificationsPermission() ?? true;
  }

  Future<void> cancelCheckIn(String bookingId) async {
    try {
      if (!kIsWeb && Platform.isLinux) return;
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
      if (!kIsWeb && Platform.isLinux) return;
      if (!_ready) await init();
      if (!_ready) return;
      await cancelCheckIn(bookingId);
      if (status != 'confirmed') return;
      if (!await _ensurePermission()) return;

      final dayBefore = DateTime(
        checkIn.year,
        checkIn.month,
        checkIn.day,
      ).subtract(const Duration(days: 1));
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

  Future<bool> showUnpaidReminder(Invoice invoice) async {
    try {
      if (!kIsWeb && Platform.isLinux) return false;
      if (!_ready) await init();
      if (!_ready || !await _ensurePermission()) return false;
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
      return true;
    } catch (e) {
      debugPrint('showUnpaidReminder error: $e');
      return false;
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
        if (row.effectiveStatus == 'paid') continue;
        if (!inv.dateIssued.isBefore(cutoff)) continue;
        final sent = inv.reminderSentAt;
        if (sent != null && !sent.isBefore(cutoff)) continue;
        if (await showUnpaidReminder(inv)) {
          await repo.markReminderSent(inv.id);
          n++;
        }
      }
      return n;
    } catch (e) {
      debugPrint('checkUnpaidInvoices error: $e');
      return 0;
    }
  }

  Future<void> reconcileAfterRestore(AppDatabase db) async {
    if (kIsWeb || Platform.isLinux) return;
    if (!_ready) await init();
    if (!_ready) return;

    await _plugin.cancelAll();
    final villas = {
      for (final villa in await db.select(db.villas).get())
        villa.id: villa.name,
    };
    final bookings = await db.select(db.bookings).get();
    for (final booking in bookings) {
      await scheduleCheckIn(
        bookingId: booking.id,
        guestName: booking.guestName,
        villaName: villas[booking.villaId] ?? 'Villa',
        checkIn: booking.checkIn,
        status: booking.status,
      );
    }
    await checkUnpaidInvoices(InvoiceRepository(db));
  }
}
