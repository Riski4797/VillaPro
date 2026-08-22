import 'package:flutter_test/flutter_test.dart';
import 'package:villa_manager/core/utils/booking_utils.dart';

void main() {
  test('normalizeWa', () {
    expect(normalizeWa('08123456789'), '628123456789');
    expect(normalizeWa('628123456789'), '628123456789');
    expect(normalizeWa('8123456789'), '628123456789');
  });

  test('dateRangeOverlap', () {
    final a = DateTime(2026, 8, 1);
    final b = DateTime(2026, 8, 5);
    final c = DateTime(2026, 8, 4);
    final d = DateTime(2026, 8, 10);
    expect(dateRangeOverlap(a, b, c, d), true);
    expect(dateRangeOverlap(a, b, b, d), false); // adjacent checkout=checkin OK
    expect(dateRangeOverlap(a, b, DateTime(2026, 7, 1), DateTime(2026, 7, 31)),
        false);
  });

  test('nightsBetween', () {
    expect(nightsBetween(DateTime(2026, 8, 1), DateTime(2026, 8, 4)), 3);
  });

  test('bookingPhase', () {
    final now = DateTime(2026, 8, 10);
    expect(
      bookingPhase(DateTime(2026, 8, 15), DateTime(2026, 8, 18), 'confirmed',
          now: now),
      BookingPhase.upcoming,
    );
    expect(
      bookingPhase(DateTime(2026, 8, 8), DateTime(2026, 8, 12), 'confirmed',
          now: now),
      BookingPhase.ongoing,
    );
    expect(
      bookingPhase(DateTime(2026, 8, 1), DateTime(2026, 8, 5), 'confirmed',
          now: now),
      BookingPhase.done,
    );
    expect(
      bookingPhase(DateTime(2026, 8, 15), DateTime(2026, 8, 18), 'cancelled',
          now: now),
      BookingPhase.cancelled,
    );
  });
}
