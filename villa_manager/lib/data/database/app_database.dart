import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/app_settings.dart';
import 'tables/bookings.dart';
import 'tables/invoice_payments.dart';
import 'tables/invoices.dart';
import 'tables/villa_faqs.dart';
import 'tables/villa_photos.dart';
import 'tables/villas.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Villas,
  VillaPhotos,
  VillaFaqs,
  Bookings,
  Invoices,
  InvoiceItems,
  InvoicePayments,
  AppSettings,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _open());

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(villaPhotos);
            await m.createTable(villaFaqs);
          }
          if (from < 3) {
            await m.createTable(bookings);
          }
          if (from < 4) {
            await m.createTable(invoices);
            await m.createTable(invoiceItems);
          }
          if (from < 5) {
            await m.addColumn(villas, villas.commissionType);
            await m.addColumn(villas, villas.commissionFixed);
          }
          if (from < 6) {
            await m.createTable(invoicePayments);
          }
          if (from < 7) {
            await m.createTable(appSettings);
          }
          if (from < 8) {
            await m.addColumn(villas, villas.ownerBank);
            await m.addColumn(villas, villas.butlerName);
            await m.addColumn(villas, villas.butlerContact);
            await m.addColumn(villas, villas.isButlerSameAsOwner);
            await m.addColumn(appSettings, appSettings.templateTeaser);
            await m.addColumn(appSettings, appSettings.templateDetail);
            await m.addColumn(
                appSettings, appSettings.templateButlerNotification);
          }
          if (from < 9) {
            await m.addColumn(appSettings, appSettings.logoPath);
            await m.addColumn(villaPhotos, villaPhotos.mediaType);
          }
        },
      );

  static QueryExecutor _open() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      return NativeDatabase.createInBackground(
        File(p.join(dir.path, 'villa_manager.db')),
      );
    });
  }
}
