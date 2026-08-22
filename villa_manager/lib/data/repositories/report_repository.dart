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

  Future<int> _invoiceTotal(String invoiceId) async {
    final items = await (_db.select(_db.invoiceItems)
          ..where((t) => t.invoiceId.equals(invoiceId)))
        .get();
    var s = 0;
    for (final i in items) {
      s += i.qty * i.price;
    }
    return s;
  }

  Future<DashboardSnapshot> dashboard() async {
    final today = DateTime.now();
    final t0 = DateTime(today.year, today.month, today.day);
    final t7 = t0.add(const Duration(days: 7));

    final activeVillas = await (_db.select(_db.villas)
          ..where((t) => t.isActive.equals(true)))
        .get()
        .then((l) => l.length);

    final bookings = await (_db.select(_db.bookings)
          ..where((t) => t.status.equals('confirmed')))
        .get();
    final activeBookings = bookings.where((b) {
      final cout = DateTime(b.checkOut.year, b.checkOut.month, b.checkOut.day);
      return !cout.isBefore(t0);
    }).length;

    final unpaid = await (_db.select(_db.invoices)
          ..where((t) => t.status.equals('unpaid')))
        .get();
    var unpaidTotal = 0;
    for (final inv in unpaid) {
      unpaidTotal += await _invoiceTotal(inv.id);
    }

    final upcoming = <UpcomingCheckIn>[];
    for (final b in bookings) {
      final cin = DateTime(b.checkIn.year, b.checkIn.month, b.checkIn.day);
      if (!cin.isBefore(t0) && cin.isBefore(t7.add(const Duration(days: 1)))) {
        final villa = await (_db.select(_db.villas)
              ..where((t) => t.id.equals(b.villaId)))
            .getSingleOrNull();
        upcoming.add(UpcomingCheckIn(
          guestName: b.guestName,
          villaName: villa?.name ?? '—',
          checkIn: b.checkIn,
        ));
      }
    }
    upcoming.sort((a, b) => a.checkIn.compareTo(b.checkIn));

    return DashboardSnapshot(
      activeVillas: activeVillas,
      activeBookings: activeBookings,
      unpaidCount: unpaid.length,
      unpaidTotal: unpaidTotal,
      upcomingCheckIns: upcoming,
    );
  }

  /// Paid invoices with dateIssued in [from, to] (inclusive dates).
  Future<ReportSummary> summary(DateTime from, DateTime to) async {
    final start = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day, 23, 59, 59);

    final paid = await (_db.select(_db.invoices)
          ..where((t) => t.status.equals('paid')))
        .get();

    final byVilla = <String, VillaReportRow>{};
    var omzet = 0;
    var komisi = 0;

    for (final inv in paid) {
      final issued = inv.dateIssued;
      if (issued.isBefore(start) || issued.isAfter(end)) continue;

      final total = await _invoiceTotal(inv.id);
      omzet += total;

      final booking = await (_db.select(_db.bookings)
            ..where((t) => t.id.equals(inv.bookingId)))
          .getSingleOrNull();
      var k = 0;
      if (booking != null) {
        final villa = await (_db.select(_db.villas)
              ..where((t) => t.id.equals(booking.villaId)))
            .getSingleOrNull();
        if (villa != null) {
          k = villa.commissionType == 'fixed'
              ? villa.commissionFixed
              : (total * villa.commissionPercent / 100).round();
        }
      }
      komisi += k;

      final name = inv.villaName;
      final prev = byVilla[name];
      byVilla[name] = VillaReportRow(
        villaName: name,
        bookingCount: (prev?.bookingCount ?? 0) + 1,
        omzet: (prev?.omzet ?? 0) + total,
        komisi: (prev?.komisi ?? 0) + k,
      );
    }

    final rows = byVilla.values.toList()
      ..sort((a, b) => b.omzet.compareTo(a.omzet));
    return ReportSummary(omzet: omzet, komisi: komisi, byVilla: rows);
  }
}
