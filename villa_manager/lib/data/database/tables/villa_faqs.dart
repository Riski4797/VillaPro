import 'package:drift/drift.dart';

import 'villas.dart';

@TableIndex(name: 'villa_faqs_villa', columns: {#villaId})
class VillaFaqs extends Table {
  TextColumn get id => text()();
  TextColumn get villaId =>
      text().references(Villas, #id, onDelete: KeyAction.cascade)();
  TextColumn get question => text()();
  TextColumn get answer => text()();

  @override
  Set<Column> get primaryKey => {id};
}
