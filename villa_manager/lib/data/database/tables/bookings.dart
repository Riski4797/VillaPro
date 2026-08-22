import 'package:drift/drift.dart';

class Bookings extends Table {
  TextColumn get id => text()();
  TextColumn get villaId => text()();
  TextColumn get guestName => text()();
  TextColumn get guestContact => text().withDefault(const Constant(''))();
  DateTimeColumn get checkIn => dateTime()();
  DateTimeColumn get checkOut => dateTime()();
  IntColumn get pricePerNightSnapshot => integer().withDefault(const Constant(0))();
  /// `confirmed` | `cancelled`
  TextColumn get status => text().withDefault(const Constant('confirmed'))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
