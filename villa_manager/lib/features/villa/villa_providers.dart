import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../data/repositories/booking_repository.dart';
import '../../data/repositories/villa_repository.dart';
import '../booking/booking_providers.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final villaRepoProvider = Provider<VillaRepository>(
  (ref) => VillaRepository(ref.watch(databaseProvider)),
);

final villaActiveOnlyProvider = StateProvider<bool>((_) => true);
final villaSearchProvider = StateProvider<String>((_) => '');

final villaListProvider = StreamProvider<List<Villa>>((ref) {
  final repo = ref.watch(villaRepoProvider);
  final activeOnly = ref.watch(villaActiveOnlyProvider);
  final search = ref.watch(villaSearchProvider);
  return repo.watchSearch(search, activeOnly: activeOnly);
});

final allVillasProvider = StreamProvider<List<Villa>>(
  (ref) => ref.watch(villaRepoProvider).watchAll(activeOnly: false),
);

final villaDetailProvider = StreamProvider.autoDispose.family<Villa?, String>(
  (ref, id) => ref.watch(villaRepoProvider).watchById(id),
);

final villaPhotosProvider = StreamProvider.autoDispose
    .family<List<VillaPhoto>, String>(
      (ref, villaId) => ref.watch(villaRepoProvider).watchPhotos(villaId),
    );

final villaFaqsProvider = StreamProvider.autoDispose
    .family<List<VillaFaq>, String>(
      (ref, villaId) => ref.watch(villaRepoProvider).watchFaqs(villaId),
    );

final villaThumbProvider = StreamProvider.autoDispose
    .family<VillaPhoto?, String>(
      (ref, villaId) => ref.watch(villaRepoProvider).watchFirstPhoto(villaId),
    );

final villaOccupancyProvider = StreamProvider.autoDispose
    .family<VillaOccupancyStatus, String>(
      (ref, villaId) => ref
          .watch(bookingRepoProvider)
          .watchOccupancyStatus(
            villaId,
            onDate: ref.watch(todayProvider).valueOrNull,
          ),
    );

class SmartMatcherFilter {
  const SmartMatcherFilter({
    this.checkIn,
    this.checkOut,
    this.maxPrice,
    this.locationQuery,
  });

  final DateTime? checkIn;
  final DateTime? checkOut;
  final int? maxPrice;
  final String? locationQuery;

  bool get isActive =>
      checkIn != null ||
      (maxPrice != null && maxPrice! > 0) ||
      (locationQuery != null && locationQuery!.trim().isNotEmpty);
}

final smartMatcherFilterProvider = StateProvider<SmartMatcherFilter>(
  (_) => const SmartMatcherFilter(),
);

final smartMatchedVillasProvider = FutureProvider<List<Villa>>((ref) async {
  final filter = ref.watch(smartMatcherFilterProvider);
  ref.watch(bookingListProvider);
  final repo = ref.watch(villaRepoProvider);
  final activeOnly = ref.watch(villaActiveOnlyProvider);
  if (!filter.isActive) {
    return repo.watchAll(activeOnly: activeOnly).first;
  }
  return repo.findAvailableVillas(
    checkIn: filter.checkIn,
    checkOut: filter.checkOut,
    maxPrice: filter.maxPrice,
    locationQuery: filter.locationQuery,
    activeOnly: activeOnly,
  );
});
