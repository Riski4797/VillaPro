import 'package:drift/drift.dart';

class InvoicePayments extends Table {
  TextColumn get id => text()();
  TextColumn get invoiceId => text()();
  IntColumn get amount => integer().withDefault(const Constant(0))();
  DateTimeColumn get datePaid => dateTime()();
  TextColumn get paymentMethod =>
      text().withDefault(const Constant('Transfer Bank'))();
  TextColumn get notes => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}
