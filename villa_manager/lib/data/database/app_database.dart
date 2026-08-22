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

@DriftDatabase(
  tables: [
    Villas,
    VillaPhotos,
    VillaFaqs,
    Bookings,
    Invoices,
    InvoiceItems,
    InvoicePayments,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _open());

  @override
  int get schemaVersion => 10;

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
        if (from >= 7) {
          await m.addColumn(appSettings, appSettings.templateTeaser);
          await m.addColumn(appSettings, appSettings.templateDetail);
          await m.addColumn(
            appSettings,
            appSettings.templateButlerNotification,
          );
        }
      }
      if (from < 9) {
        if (from >= 7) {
          await m.addColumn(appSettings, appSettings.logoPath);
        }
        if (from >= 2) {
          await m.addColumn(villaPhotos, villaPhotos.mediaType);
        }
      }
      if (from < 10) {
        await transaction(() async {
          await _prepareForV10();
          await m.alterTable(TableMigration(villas));
          if (from >= 2) {
            await m.alterTable(TableMigration(villaPhotos));
            await m.alterTable(TableMigration(villaFaqs));
          }
          if (from >= 3) {
            await m.alterTable(
              TableMigration(
                bookings,
                newColumns: [
                  bookings.commissionTypeSnapshot,
                  bookings.commissionPercentSnapshot,
                  bookings.commissionFixedSnapshot,
                ],
              ),
            );
            await customStatement('''
                  UPDATE bookings
                  SET commission_type_snapshot = COALESCE(
                        (SELECT commission_type FROM villas WHERE villas.id = bookings.villa_id),
                        'percent'
                      ),
                      commission_percent_snapshot = COALESCE(
                        (SELECT commission_percent FROM villas WHERE villas.id = bookings.villa_id),
                        0
                      ),
                      commission_fixed_snapshot = COALESCE(
                        (SELECT commission_fixed FROM villas WHERE villas.id = bookings.villa_id),
                        0
                      )
                ''');
          }
          if (from >= 4) {
            await m.alterTable(
              TableMigration(
                invoices,
                newColumns: [
                  invoices.commissionTypeSnapshot,
                  invoices.commissionPercentSnapshot,
                  invoices.commissionFixedSnapshot,
                ],
              ),
            );
            await customStatement('''
                  UPDATE invoices
                  SET commission_type_snapshot = COALESCE(
                        (SELECT commission_type_snapshot FROM bookings WHERE bookings.id = invoices.booking_id),
                        'percent'
                      ),
                      commission_percent_snapshot = COALESCE(
                        (SELECT commission_percent_snapshot FROM bookings WHERE bookings.id = invoices.booking_id),
                        0
                      ),
                      commission_fixed_snapshot = COALESCE(
                        (SELECT commission_fixed_snapshot FROM bookings WHERE bookings.id = invoices.booking_id),
                        0
                      )
                ''');
            await m.alterTable(TableMigration(invoiceItems));
          }
          if (from >= 6) {
            await m.alterTable(TableMigration(invoicePayments));
          }
          if (from >= 7) {
            await m.alterTable(TableMigration(appSettings));
          }
          for (final index in [
            villaPhotosVillaOrder,
            villaFaqsVilla,
            bookingsVillaDates,
            bookingsStatus,
            invoicesStatusDate,
            invoiceItemsInvoice,
            invoicePaymentsInvoiceDate,
          ]) {
            await customStatement('DROP INDEX IF EXISTS ${index.entityName}');
            await m.createIndex(index);
          }

          final violations = await customSelect(
            'PRAGMA foreign_key_check',
          ).get();
          if (violations.isNotEmpty) {
            throw StateError('Invalid relationships in legacy database');
          }
        });
      }
    },
    beforeOpen: (_) async {
      await customStatement('PRAGMA foreign_keys = ON');
      final violations = await customSelect('PRAGMA foreign_key_check').get();
      if (violations.isNotEmpty) {
        throw StateError('Database contains invalid relationships');
      }
    },
  );

  Future<void> _prepareForV10() async {
    await customStatement('''
      UPDATE villas
      SET price_weekday = MAX(price_weekday, 0),
          price_weekend = MAX(price_weekend, 0),
          price_high_season = MAX(price_high_season, 0),
          commission_percent = MIN(MAX(commission_percent, 0), 100),
          commission_type = CASE
            WHEN commission_type IN ('percent', 'fixed') THEN commission_type
            ELSE 'percent'
          END,
          commission_fixed = MAX(commission_fixed, 0)
    ''');

    await customStatement('''
      DELETE FROM villa_photos
      WHERE villa_id NOT IN (SELECT id FROM villas)
    ''');
    await customStatement('''
      UPDATE villa_photos
      SET media_type = CASE
            WHEN media_type IN ('photo', 'video') THEN media_type
            ELSE 'photo'
          END,
          sort_order = MAX(sort_order, 0)
    ''');
    await customStatement('''
      DELETE FROM villa_faqs
      WHERE villa_id NOT IN (SELECT id FROM villas)
    ''');

    await customStatement('''
      DELETE FROM bookings
      WHERE villa_id NOT IN (SELECT id FROM villas)
    ''');
    await customStatement('''
      UPDATE bookings
      SET check_out = CASE
            WHEN check_out > check_in THEN check_out
            ELSE check_in + 86400
          END,
          price_per_night_snapshot = MAX(price_per_night_snapshot, 0),
          status = CASE
            WHEN status IN ('confirmed', 'cancelled') THEN status
            ELSE 'confirmed'
          END
    ''');

    await customStatement('''
      DELETE FROM invoice_items
      WHERE invoice_id NOT IN (SELECT id FROM invoices)
    ''');
    await customStatement('''
      DELETE FROM invoice_payments
      WHERE invoice_id NOT IN (SELECT id FROM invoices)
    ''');
    await customStatement('''
      DELETE FROM invoices
      WHERE booking_id NOT IN (SELECT id FROM bookings)
    ''');
    await customStatement('''
      UPDATE invoices
      SET invoice_number = invoice_number || '-DUP-' || substr(id, 1, 8)
      WHERE rowid NOT IN (
        SELECT MIN(rowid) FROM invoices GROUP BY invoice_number
      )
    ''');
    await customStatement('DROP TABLE IF EXISTS villapro_duplicate_invoices');
    await customStatement('''
      CREATE TEMP TABLE villapro_duplicate_invoices AS
      SELECT id FROM invoices
      WHERE rowid NOT IN (
        SELECT MIN(rowid) FROM invoices GROUP BY booking_id
      )
    ''');
    await customStatement('''
      DELETE FROM invoice_items
      WHERE invoice_id IN (SELECT id FROM villapro_duplicate_invoices)
    ''');
    await customStatement('''
      DELETE FROM invoice_payments
      WHERE invoice_id IN (SELECT id FROM villapro_duplicate_invoices)
    ''');
    await customStatement('''
      DELETE FROM invoices
      WHERE id IN (SELECT id FROM villapro_duplicate_invoices)
    ''');
    await customStatement('DROP TABLE villapro_duplicate_invoices');
    await customStatement('''
      UPDATE invoices
      SET check_out = CASE
            WHEN check_out > check_in THEN check_out
            ELSE check_in + 86400
          END,
          status = CASE
            WHEN status IN ('unpaid', 'partial', 'paid') THEN status
            ELSE 'unpaid'
          END
    ''');
    await customStatement('''
      UPDATE invoice_items
      SET qty = MAX(qty, 1), price = MAX(price, 0)
    ''');
    await customStatement('''
      DELETE FROM invoice_payments
      WHERE amount <= 0 OR invoice_id NOT IN (SELECT id FROM invoices)
    ''');

    await customStatement('''
      UPDATE app_settings
      SET bank_accounts = ''
      WHERE bank_accounts IN (
        '- BCA: 123-456-7890 a.n. Villa Manager',
        '- BCA: 123-456-7890 a.n. Villa Manager
- Mandiri: 987-654-3210 a.n. Villa Manager'
      )
    ''');
  }

  static QueryExecutor _open() {
    return LazyDatabase(() async {
      // Keep the original storage location so existing installations continue
      // opening the database that the pre-release app already created.
      final dir = await getApplicationDocumentsDirectory();
      return NativeDatabase.createInBackground(
        File(p.join(dir.path, 'villa_manager.db')),
      );
    });
  }
}
