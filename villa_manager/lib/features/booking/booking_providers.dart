import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/booking_utils.dart';
import '../../data/repositories/booking_repository.dart';
import '../villa/villa_providers.dart';

final bookingRepoProvider = Provider<BookingRepository>(
  (ref) => BookingRepository(ref.watch(databaseProvider)),
);

enum BookingFilter { all, upcoming, ongoing, done, cancelled }

final bookingFilterProvider = StateProvider<BookingFilter>(
  (_) => BookingFilter.all,
);

final todayProvider = StreamProvider<DateTime>((ref) {
  final controller = StreamController<DateTime>();
  Timer? timer;

  void update() {
    final now = DateTime.now();
    controller.add(DateTime(now.year, now.month, now.day));
    final nextDay = DateTime(now.year, now.month, now.day + 1);
    timer = Timer(nextDay.difference(now), update);
  }

  ref.onDispose(() {
    timer?.cancel();
    controller.close();
  });
  update();
  return controller.stream;
});

final bookingListProvider = StreamProvider<List<BookingWithVilla>>((ref) {
  return ref.watch(bookingRepoProvider).watchAll();
});

final filteredBookingsProvider = Provider<AsyncValue<List<BookingWithVilla>>>((
  ref,
) {
  final filter = ref.watch(bookingFilterProvider);
  final today = ref.watch(todayProvider).valueOrNull ?? DateTime.now();
  final async = ref.watch(bookingListProvider);
  return async.whenData((list) {
    if (filter == BookingFilter.all) return list;
    return list.where((b) {
      final phase = bookingPhase(
        b.booking.checkIn,
        b.booking.checkOut,
        b.booking.status,
        now: today,
      );
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
