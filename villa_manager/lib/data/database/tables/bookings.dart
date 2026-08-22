import 'package:drift/drift.dart';

import 'villas.dart';

@TableIndex(
  name: 'bookings_villa_dates',
  columns: {#villaId, #checkIn, #checkOut},
)
@TableIndex(name: 'bookings_status', columns: {#status})
class Bookings extends Table {
  TextColumn get id => text()();
  TextColumn get villaId =>
      text().references(Villas, #id, onDelete: KeyAction.restrict)();
  TextColumn get guestName => text()();
  TextColumn get guestContact => text().withDefault(const Constant(''))();
  DateTimeColumn get checkIn => dateTime()();
  DateTimeColumn get checkOut => dateTime()();
  IntColumn get pricePerNightSnapshot =>
      integer().withDefault(const Constant(0))();
  TextColumn get commissionTypeSnapshot =>
      text().withDefault(const Constant('percent'))();
  RealColumn get commissionPercentSnapshot =>
      real().withDefault(const Constant(0.0))();
  IntColumn get commissionFixedSnapshot =>
      integer().withDefault(const Constant(0))();

  /// `confirmed` | `cancelled`
  TextColumn get status => text().withDefault(const Constant('confirmed'))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'CHECK (check_out > check_in)',
    'CHECK (price_per_night_snapshot >= 0)',
    "CHECK (status IN ('confirmed', 'cancelled'))",
    "CHECK (commission_type_snapshot IN ('percent', 'fixed'))",
    'CHECK (commission_percent_snapshot >= 0 AND commission_percent_snapshot <= 100)',
    'CHECK (commission_fixed_snapshot >= 0)',
  ];
}
