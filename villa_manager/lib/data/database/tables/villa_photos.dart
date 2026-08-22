import 'package:drift/drift.dart';

import 'villas.dart';

@TableIndex(name: 'villa_photos_villa_order', columns: {#villaId, #sortOrder})
class VillaPhotos extends Table {
  TextColumn get id => text()();
  TextColumn get villaId =>
      text().references(Villas, #id, onDelete: KeyAction.cascade)();
  TextColumn get filePath => text()();

  /// `photo` | `video`
  TextColumn get mediaType => text().withDefault(const Constant('photo'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    "CHECK (media_type IN ('photo', 'video'))",
    'CHECK (sort_order >= 0)',
  ];
}
