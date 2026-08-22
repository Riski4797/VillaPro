import 'package:drift/drift.dart';

class VillaPhotos extends Table {
  TextColumn get id => text()();
  TextColumn get villaId => text()();
  TextColumn get filePath => text()();
  /// `photo` | `video`
  TextColumn get mediaType => text().withDefault(const Constant('photo'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
