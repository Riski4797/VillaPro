import 'package:drift/drift.dart';

import 'invoices.dart';

@TableIndex(
  name: 'invoice_payments_invoice_date',
  columns: {#invoiceId, #datePaid},
)
class InvoicePayments extends Table {
  TextColumn get id => text()();
  TextColumn get invoiceId =>
      text().references(Invoices, #id, onDelete: KeyAction.cascade)();
  IntColumn get amount => integer().withDefault(const Constant(0))();
  DateTimeColumn get datePaid => dateTime()();
  TextColumn get paymentMethod =>
      text().withDefault(const Constant('Transfer Bank'))();
  TextColumn get notes => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['CHECK (amount > 0)'];
}
