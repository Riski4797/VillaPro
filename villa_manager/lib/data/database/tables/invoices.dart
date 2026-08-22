import 'package:drift/drift.dart';

class Invoices extends Table {
  TextColumn get id => text()();
  TextColumn get invoiceNumber => text()();
  TextColumn get bookingId => text()();
  TextColumn get guestName => text()();
  TextColumn get villaName => text()();
  DateTimeColumn get checkIn => dateTime()();
  DateTimeColumn get checkOut => dateTime()();
  /// `unpaid` | `paid`
  TextColumn get status => text().withDefault(const Constant('unpaid'))();
  DateTimeColumn get dateIssued => dateTime()();
  DateTimeColumn get datePaid => dateTime().nullable()();
  DateTimeColumn get reminderSentAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class InvoiceItems extends Table {
  TextColumn get id => text()();
  TextColumn get invoiceId => text()();
  TextColumn get description => text()();
  IntColumn get qty => integer().withDefault(const Constant(1))();
  IntColumn get price => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
