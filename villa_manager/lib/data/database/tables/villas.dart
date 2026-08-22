import 'package:drift/drift.dart';

class Villas extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get location => text().withDefault(const Constant(''))();
  TextColumn get ownerName => text().withDefault(const Constant(''))();
  TextColumn get ownerContact => text().withDefault(const Constant(''))();
  TextColumn get ownerBank => text().withDefault(const Constant(''))();
  TextColumn get butlerName => text().withDefault(const Constant(''))();
  TextColumn get butlerContact => text().withDefault(const Constant(''))();
  BoolColumn get isButlerSameAsOwner =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get uniqueSellingPoints =>
      text().withDefault(const Constant('[]'))();
  TextColumn get amenities => text().withDefault(const Constant('[]'))();
  TextColumn get houseRules => text().withDefault(const Constant(''))();
  IntColumn get priceWeekday => integer().withDefault(const Constant(0))();
  IntColumn get priceWeekend => integer().withDefault(const Constant(0))();
  IntColumn get priceHighSeason => integer().withDefault(const Constant(0))();
  RealColumn get commissionPercent => real().withDefault(const Constant(0.0))();
  /// `percent` | `fixed`
  TextColumn get commissionType =>
      text().withDefault(const Constant('percent'))();
  IntColumn get commissionFixed => integer().withDefault(const Constant(0))();
  TextColumn get privateNotes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
