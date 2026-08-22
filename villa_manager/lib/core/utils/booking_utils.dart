/// Normalize WA number to 62xxx (digits only).
String normalizeWa(String raw) {
  var d = raw.replaceAll(RegExp(r'\D'), '');
  if (d.startsWith('0')) d = '62${d.substring(1)}';
  if (d.startsWith('8')) d = '62$d';
  return d;
}

bool dateRangeOverlap(
  DateTime aIn,
  DateTime aOut,
  DateTime bIn,
  DateTime bOut,
) {
  // compare date-only
  final ai = DateTime(aIn.year, aIn.month, aIn.day);
  final ao = DateTime(aOut.year, aOut.month, aOut.day);
  final bi = DateTime(bIn.year, bIn.month, bIn.day);
  final bo = DateTime(bOut.year, bOut.month, bOut.day);
  return ai.isBefore(bo) && ao.isAfter(bi);
}

int nightsBetween(DateTime checkIn, DateTime checkOut) {
  final a = DateTime(checkIn.year, checkIn.month, checkIn.day);
  final b = DateTime(checkOut.year, checkOut.month, checkOut.day);
  return b.difference(a).inDays.clamp(0, 9999);
}

enum BookingPhase { upcoming, ongoing, done, cancelled }

BookingPhase bookingPhase(
  DateTime checkIn,
  DateTime checkOut,
  String status, {
  DateTime? now,
}) {
  if (status == 'cancelled') return BookingPhase.cancelled;
  final today = now ?? DateTime.now();
  final t = DateTime(today.year, today.month, today.day);
  final cin = DateTime(checkIn.year, checkIn.month, checkIn.day);
  final cout = DateTime(checkOut.year, checkOut.month, checkOut.day);
  if (t.isBefore(cin)) return BookingPhase.upcoming;
  if (!t.isBefore(cout)) return BookingPhase.done;
  return BookingPhase.ongoing;
}

String bookingPhaseLabel(BookingPhase p) => switch (p) {
  BookingPhase.upcoming => 'Akan datang',
  BookingPhase.ongoing => 'Berlangsung',
  BookingPhase.done => 'Selesai',
  BookingPhase.cancelled => 'Batal',
};
