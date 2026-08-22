import 'package:drift/drift.dart';

import 'bookings.dart';

@TableIndex(name: 'invoices_status_date', columns: {#status, #dateIssued})
class Invoices extends Table {
  TextColumn get id => text()();
  TextColumn get invoiceNumber => text()();
  TextColumn get bookingId =>
      text().references(Bookings, #id, onDelete: KeyAction.restrict)();
  TextColumn get guestName => text()();
  TextColumn get villaName => text()();
  DateTimeColumn get checkIn => dateTime()();
  DateTimeColumn get checkOut => dateTime()();
  TextColumn get commissionTypeSnapshot =>
      text().withDefault(const Constant('percent'))();
  RealColumn get commissionPercentSnapshot =>
      real().withDefault(const Constant(0.0))();
  IntColumn get commissionFixedSnapshot =>
      integer().withDefault(const Constant(0))();

  /// `unpaid` | `partial` | `paid`
  TextColumn get status => text().withDefault(const Constant('unpaid'))();
  DateTimeColumn get dateIssued => dateTime()();
  DateTimeColumn get datePaid => dateTime().nullable()();
  DateTimeColumn get reminderSentAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {invoiceNumber},
    {bookingId},
  ];

  @override
  List<String> get customConstraints => [
    'CHECK (check_out > check_in)',
    "CHECK (status IN ('unpaid', 'partial', 'paid'))",
    "CHECK (commission_type_snapshot IN ('percent', 'fixed'))",
    'CHECK (commission_percent_snapshot >= 0 AND commission_percent_snapshot <= 100)',
    'CHECK (commission_fixed_snapshot >= 0)',
  ];
}

@TableIndex(name: 'invoice_items_invoice', columns: {#invoiceId})
class InvoiceItems extends Table {
  TextColumn get id => text()();
  TextColumn get invoiceId =>
      text().references(Invoices, #id, onDelete: KeyAction.cascade)();
  TextColumn get description => text()();
  IntColumn get qty => integer().withDefault(const Constant(1))();
  IntColumn get price => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'CHECK (qty > 0)',
    'CHECK (price >= 0)',
  ];
}
