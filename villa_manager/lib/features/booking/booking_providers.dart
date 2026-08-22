import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/booking_utils.dart';
import '../../data/repositories/booking_repository.dart';
import '../villa/villa_providers.dart';

final bookingRepoProvider = Provider<BookingRepository>(
  (ref) => BookingRepository(ref.watch(databaseProvider)),
);

enum BookingFilter { all, upcoming, ongoing, done, cancelled }

final bookingFilterProvider =
    StateProvider<BookingFilter>((_) => BookingFilter.all);

final bookingListProvider = StreamProvider<List<BookingWithVilla>>((ref) {
  return ref.watch(bookingRepoProvider).watchAll();
});

final filteredBookingsProvider = Provider<AsyncValue<List<BookingWithVilla>>>((ref) {
  final filter = ref.watch(bookingFilterProvider);
  final async = ref.watch(bookingListProvider);
  return async.whenData((list) {
    if (filter == BookingFilter.all) return list;
    return list.where((b) {
      final phase = bookingPhase(
          b.booking.checkIn, b.booking.checkOut, b.booking.status);
      return switch (filter) {
        BookingFilter.upcoming => phase == BookingPhase.upcoming,
        BookingFilter.ongoing => phase == BookingPhase.ongoing,
        BookingFilter.done => phase == BookingPhase.done,
        BookingFilter.cancelled => phase == BookingPhase.cancelled,
        BookingFilter.all => true,
      };
    }).toList();
  });
});
