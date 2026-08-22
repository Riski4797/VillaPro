import 'package:drift/drift.dart';

class VillaFaqs extends Table {
  TextColumn get id => text()();
  TextColumn get villaId => text()();
  TextColumn get question => text()();
  TextColumn get answer => text()();

  @override
  Set<Column> get primaryKey => {id};
}
