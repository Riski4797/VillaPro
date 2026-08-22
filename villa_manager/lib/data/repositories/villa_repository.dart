import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../services/photo_storage_service.dart';
import '../database/app_database.dart';

class VillaRepository {
  VillaRepository(this._db, [PhotoStorageService? photos])
    : _photos = photos ?? PhotoStorageService();
  final AppDatabase _db;
  final PhotoStorageService _photos;
  static const _uuid = Uuid();

  Stream<List<Villa>> watchAll({bool activeOnly = true}) {
    final q = _db.select(_db.villas);
    if (activeOnly) q.where((t) => t.isActive.equals(true));
    q.orderBy([(t) => OrderingTerm.asc(t.name)]);
    return q.watch();
  }

  Stream<List<Villa>> watchSearch(String query, {bool activeOnly = true}) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return watchAll(activeOnly: activeOnly);
    final sel = _db.select(_db.villas)
      ..where((t) {
        final match =
            t.name.lower().contains(q) | t.location.lower().contains(q);
        return activeOnly ? match & t.isActive.equals(true) : match;
      })
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return sel.watch();
  }

  Future<Villa?> getById(String id) =>
      (_db.select(_db.villas)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<Villa?> watchById(String id) {
    return (_db.select(_db.villas)..where((t) => t.id.equals(id))).watch().map(
      (rows) => rows.isEmpty ? null : rows.first,
    );
  }

  Future<String> upsert({
    String? id,
    required String name,
    String location = '',
    String ownerName = '',
    String ownerContact = '',
    String ownerBank = '',
    String butlerName = '',
    String butlerContact = '',
    bool isButlerSameAsOwner = false,
    bool isActive = true,
    String description = '',
    List<String> usps = const [],
    List<String> amenities = const [],
    String houseRules = '',
    int priceWeekday = 0,
    int priceWeekend = 0,
    int priceHighSeason = 0,
    double commissionPercent = 0,
    String commissionType = 'percent',
    int commissionFixed = 0,
    String privateNotes = '',
  }) async {
    final now = DateTime.now();
    if (id == null) {
      final villaId = _uuid.v4();
      await _db
          .into(_db.villas)
          .insert(
            VillasCompanion.insert(
              id: villaId,
              name: name,
              location: Value(location),
              ownerName: Value(ownerName),
              ownerContact: Value(ownerContact),
              ownerBank: Value(ownerBank),
              butlerName: Value(butlerName),
              butlerContact: Value(butlerContact),
              isButlerSameAsOwner: Value(isButlerSameAsOwner),
              isActive: Value(isActive),
              description: Value(description),
              uniqueSellingPoints: Value(jsonEncode(usps)),
              amenities: Value(jsonEncode(amenities)),
              houseRules: Value(houseRules),
              priceWeekday: Value(priceWeekday),
              priceWeekend: Value(priceWeekend),
              priceHighSeason: Value(priceHighSeason),
              commissionPercent: Value(commissionPercent),
              commissionType: Value(commissionType),
              commissionFixed: Value(commissionFixed),
              privateNotes: Value(privateNotes),
              createdAt: now,
              updatedAt: now,
            ),
          );
      return villaId;
    } else {
      await (_db.update(_db.villas)..where((t) => t.id.equals(id))).write(
        VillasCompanion(
          name: Value(name),
          location: Value(location),
          ownerName: Value(ownerName),
          ownerContact: Value(ownerContact),
          ownerBank: Value(ownerBank),
          butlerName: Value(butlerName),
          butlerContact: Value(butlerContact),
          isButlerSameAsOwner: Value(isButlerSameAsOwner),
          isActive: Value(isActive),
          description: Value(description),
          uniqueSellingPoints: Value(jsonEncode(usps)),
          amenities: Value(jsonEncode(amenities)),
          houseRules: Value(houseRules),
          priceWeekday: Value(priceWeekday),
          priceWeekend: Value(priceWeekend),
          priceHighSeason: Value(priceHighSeason),
          commissionPercent: Value(commissionPercent),
          commissionType: Value(commissionType),
          commissionFixed: Value(commissionFixed),
          privateNotes: Value(privateNotes),
          updatedAt: Value(now),
        ),
      );
      return id;
    }
  }

  /// Smart Matcher: Find villas available between [checkIn] and [checkOut], with optional [maxPrice] and [locationQuery].
  Future<List<Villa>> findAvailableVillas({
    DateTime? checkIn,
    DateTime? checkOut,
    int? maxPrice,
    String? locationQuery,
    bool activeOnly = true,
  }) async {
    final query = _db.select(_db.villas);
    if (activeOnly) query.where((t) => t.isActive.equals(true));
    if (locationQuery != null && locationQuery.trim().isNotEmpty) {
      final loc = locationQuery.trim().toLowerCase();
      query.where(
        (t) => t.location.lower().contains(loc) | t.name.lower().contains(loc),
      );
    }
    if (maxPrice != null && maxPrice > 0) {
      query.where(
        (t) =>
            t.priceWeekday.isSmallerOrEqualValue(maxPrice) &
            t.priceWeekend.isSmallerOrEqualValue(maxPrice) &
            t.priceHighSeason.isSmallerOrEqualValue(maxPrice),
      );
    }
    query.orderBy([(t) => OrderingTerm.asc(t.priceWeekday)]);

    final villas = await query.get();
    if (checkIn == null || checkOut == null) return villas;

    final overlaps = villas.isEmpty
        ? <Booking>[]
        : await (_db.select(_db.bookings)..where(
                (b) =>
                    b.villaId.isIn(villas.map((v) => v.id)) &
                    b.status.equals('confirmed'),
              ))
              .get();
    final ci = DateTime(checkIn.year, checkIn.month, checkIn.day);
    final co = DateTime(checkOut.year, checkOut.month, checkOut.day);
    final available = <Villa>[];
    for (final v in villas) {
      final hasOverlap = overlaps.where((b) => b.villaId == v.id).any((b) {
        final bi = DateTime(b.checkIn.year, b.checkIn.month, b.checkIn.day);
        final bo = DateTime(b.checkOut.year, b.checkOut.month, b.checkOut.day);
        return ci.isBefore(bo) && co.isAfter(bi);
      });
      if (!hasOverlap) available.add(v);
    }
    return available;
  }

  Future<void> delete(String id) async {
    final booking =
        await (_db.select(_db.bookings)
              ..where((t) => t.villaId.equals(id))
              ..limit(1))
            .getSingleOrNull();
    if (booking != null) {
      throw StateError(
        'Villa memiliki riwayat booking dan tidak dapat dihapus',
      );
    }

    final photos = await (_db.select(
      _db.villaPhotos,
    )..where((t) => t.villaId.equals(id))).get();
    final deleted = await (_db.delete(
      _db.villas,
    )..where((t) => t.id.equals(id))).go();
    if (deleted != 1) throw StateError('Villa tidak ditemukan');
    for (final ph in photos) {
      await _photos.deleteFile(ph.filePath);
    }
  }

  // --- photos ---

  Stream<List<VillaPhoto>> watchPhotos(String villaId) {
    return (_db.select(_db.villaPhotos)
          ..where((t) => t.villaId.equals(villaId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  Stream<VillaPhoto?> watchFirstPhoto(String villaId) {
    return (_db.select(_db.villaPhotos)
          ..where(
            (t) => t.villaId.equals(villaId) & t.mediaType.equals('photo'),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])
          ..limit(1))
        .watchSingleOrNull();
  }

  Future<VillaPhoto?> firstPhoto(String villaId) {
    return (_db.select(_db.villaPhotos)
          ..where(
            (t) => t.villaId.equals(villaId) & t.mediaType.equals('photo'),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> addMedia(
    String villaId,
    String sourcePath, {
    String mediaType = 'photo',
  }) async {
    if (!const {'photo', 'video'}.contains(mediaType)) {
      throw ArgumentError.value(
        mediaType,
        'mediaType',
        'Tipe media tidak valid',
      );
    }
    final path = await _photos.importPhoto(
      sourcePath,
      optimizeImage: mediaType == 'photo',
    );
    try {
      await _db.transaction(() async {
        final maxOrder =
            await (_db.selectOnly(_db.villaPhotos)
                  ..addColumns([_db.villaPhotos.sortOrder.max()])
                  ..where(_db.villaPhotos.villaId.equals(villaId)))
                .map((row) => row.read(_db.villaPhotos.sortOrder.max()) ?? -1)
                .getSingle();
        await _db
            .into(_db.villaPhotos)
            .insert(
              VillaPhotosCompanion.insert(
                id: _uuid.v4(),
                villaId: villaId,
                filePath: path,
                mediaType: Value(mediaType),
                sortOrder: Value(maxOrder + 1),
              ),
            );
      });
    } catch (_) {
      await _photos.deleteFile(path);
      rethrow;
    }
  }

  Future<void> addPhoto(String villaId, String sourcePath) =>
      addMedia(villaId, sourcePath, mediaType: 'photo');

  Future<void> addVideo(String villaId, String sourcePath) =>
      addMedia(villaId, sourcePath, mediaType: 'video');

  Future<void> deletePhoto(VillaPhoto photo) async {
    final deleted = await (_db.delete(
      _db.villaPhotos,
    )..where((t) => t.id.equals(photo.id))).go();
    if (deleted != 1) throw StateError('Media tidak ditemukan');
    await _photos.deleteFile(photo.filePath);
  }

  // --- faqs ---

  Stream<List<VillaFaq>> watchFaqs(String villaId) {
    return (_db.select(
      _db.villaFaqs,
    )..where((t) => t.villaId.equals(villaId))).watch();
  }

  Future<void> upsertFaq({
    String? id,
    required String villaId,
    required String question,
    required String answer,
  }) {
    return _db
        .into(_db.villaFaqs)
        .insertOnConflictUpdate(
          VillaFaqsCompanion(
            id: Value(id ?? _uuid.v4()),
            villaId: Value(villaId),
            question: Value(question),
            answer: Value(answer),
          ),
        );
  }

  Future<void> deleteFaq(String id) =>
      (_db.delete(_db.villaFaqs)..where((t) => t.id.equals(id))).go();

  static List<String> decodeList(String raw) {
    try {
      return (jsonDecode(raw) as List).cast<String>();
    } catch (_) {
      return const [];
    }
  }
}
