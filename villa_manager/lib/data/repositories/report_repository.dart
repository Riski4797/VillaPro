import 'package:drift/drift.dart';

import '../database/app_database.dart';

class VillaReportRow {
  VillaReportRow({
    required this.villaName,
    required this.bookingCount,
    required this.omzet,
    required this.komisi,
  });
  final String villaName;
  final int bookingCount;
  final int omzet;
  final int komisi;
}

class ReportSummary {
  ReportSummary({
    required this.omzet,
    required this.komisi,
    required this.byVilla,
  });
  final int omzet;
  final int komisi;
  final List<VillaReportRow> byVilla;
}

class DashboardSnapshot {
  DashboardSnapshot({
    required this.activeVillas,
    required this.activeBookings,
    required this.unpaidCount,
    required this.unpaidTotal,
    required this.upcomingCheckIns,
  });
  final int activeVillas;
  final int activeBookings;
  final int unpaidCount;
  final int unpaidTotal;
  final List<UpcomingCheckIn> upcomingCheckIns;
}

class UpcomingCheckIn {
  UpcomingCheckIn({
    required this.guestName,
    required this.villaName,
    required this.checkIn,
  });
  final String guestName;
  final String villaName;
  final DateTime checkIn;
}

class ReportRepository {
  ReportRepository(this._db);
  final AppDatabase _db;

  Stream<DashboardSnapshot> watchDashboard() {
    return _db
        .customSelect(
          'SELECT 1',
          readsFrom: {
            _db.villas,
            _db.bookings,
            _db.invoices,
            _db.invoiceItems,
            _db.invoicePayments,
          },
        )
        .watch()
        .asyncMap((_) => dashboard());
  }

  Future<DashboardSnapshot> dashboard() async {
    final today = DateTime.now();
    final t0 = DateTime(today.year, today.month, today.day);
    final endUpcoming = t0.add(const Duration(days: 8));

    final counts = await _db
        .customSelect(
          '''
      SELECT (SELECT COUNT(*) FROM villas WHERE is_active = 1) AS active_villas,
             (SELECT COUNT(*) FROM bookings
              WHERE status = 'confirmed' AND check_out > ?) AS active_bookings
      ''',
          variables: [Variable.withDateTime(t0)],
        )
        .getSingle();

    final outstanding = await _db.customSelect('''
      SELECT COUNT(*) AS unpaid_count,
             COALESCE(SUM(remaining), 0) AS unpaid_total
      FROM (
        SELECT COALESCE((
                 SELECT SUM(qty * price)
                 FROM invoice_items
                 WHERE invoice_id = invoices.id
               ), 0) - COALESCE((
                 SELECT SUM(amount)
                 FROM invoice_payments
                 WHERE invoice_id = invoices.id
               ), 0) AS remaining
        FROM invoices
        WHERE status != 'paid'
      )
      WHERE remaining > 0
    ''').getSingle();

    final upcomingRows = await _db
        .customSelect(
          '''
      SELECT bookings.guest_name, villas.name AS villa_name, bookings.check_in
      FROM bookings
      LEFT JOIN villas ON villas.id = bookings.villa_id
      WHERE bookings.status = 'confirmed'
        AND bookings.check_in >= ?
        AND bookings.check_in < ?
      ORDER BY bookings.check_in
      ''',
          variables: [
            Variable.withDateTime(t0),
            Variable.withDateTime(endUpcoming),
          ],
        )
        .get();

    final upcoming = upcomingRows
        .map(
          (row) => UpcomingCheckIn(
            guestName: row.read<String>('guest_name'),
            villaName: row.readNullable<String>('villa_name') ?? '-',
            checkIn: DateTime.fromMillisecondsSinceEpoch(
              row.read<int>('check_in') * 1000,
            ),
          ),
        )
        .toList();

    return DashboardSnapshot(
      activeVillas: counts.read<int>('active_villas'),
      activeBookings: counts.read<int>('active_bookings'),
      unpaidCount: outstanding.read<int>('unpaid_count'),
      unpaidTotal: outstanding.read<int>('unpaid_total'),
      upcomingCheckIns: upcoming,
    );
  }

  /// Paid invoices settled in [from, to] (inclusive dates).
  Future<ReportSummary> summary(DateTime from, DateTime to) async {
    final start = DateTime(from.year, from.month, from.day);
    final endExclusive = DateTime(
      to.year,
      to.month,
      to.day,
    ).add(const Duration(days: 1));

    final result = await _db
        .customSelect(
          '''
      SELECT villa_name,
             COUNT(*) AS booking_count,
             COALESCE(SUM(total), 0) AS omzet,
             COALESCE(SUM(
               CASE commission_type_snapshot
                 WHEN 'fixed' THEN commission_fixed_snapshot
                 ELSE CAST(ROUND(total * commission_percent_snapshot / 100.0) AS INTEGER)
               END
             ), 0) AS komisi
      FROM invoices
      LEFT JOIN (
        SELECT invoice_id, SUM(qty * price) AS total
        FROM invoice_items
        GROUP BY invoice_id
      ) AS totals ON totals.invoice_id = invoices.id
      WHERE status = 'paid' AND date_paid >= ? AND date_paid < ?
      GROUP BY villa_name
      ORDER BY omzet DESC
      ''',
          variables: [
            Variable.withDateTime(start),
            Variable.withDateTime(endExclusive),
          ],
        )
        .get();

    final rows = result
        .map(
          (row) => VillaReportRow(
            villaName: row.read<String>('villa_name'),
            bookingCount: row.read<int>('booking_count'),
            omzet: row.read<int>('omzet'),
            komisi: row.read<int>('komisi'),
          ),
        )
        .toList();
    final omzet = rows.fold<int>(0, (sum, row) => sum + row.omzet);
    final komisi = rows.fold<int>(0, (sum, row) => sum + row.komisi);
    return ReportSummary(omzet: omzet, komisi: komisi, byVilla: rows);
  }
}
