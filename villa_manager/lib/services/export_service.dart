import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../data/database/app_database.dart';

// ponytail: import from backup not in v1 — add when restore flow is needed
class ExportService {
  ExportService(this._db);
  final AppDatabase _db;

  Future<File> buildZip() async {
    final tmp = await getTemporaryDirectory();
    final stamp = DateFormat('yyyyMMdd').format(DateTime.now());
    final workDir = Directory(p.join(tmp.path, 'vm_backup_$stamp'));
    if (await workDir.exists()) await workDir.delete(recursive: true);
    await workDir.create(recursive: true);

    final photosDir = Directory(p.join(workDir.path, 'photos'));
    await photosDir.create();

    final villas = await _db.select(_db.villas).get();
    final photos = await _db.select(_db.villaPhotos).get();
    final faqs = await _db.select(_db.villaFaqs).get();
    final bookings = await _db.select(_db.bookings).get();
    final invoices = await _db.select(_db.invoices).get();
    final items = await _db.select(_db.invoiceItems).get();
    final payments = await _db.select(_db.invoicePayments).get();

    final photoPaths = <String, String>{};
    for (final ph in photos) {
      final src = File(ph.filePath);
      if (!await src.exists()) continue;
      final name = '${ph.id}${p.extension(ph.filePath)}';
      await src.copy(p.join(photosDir.path, name));
      photoPaths[ph.id] = 'photos/$name';
    }

    final data = {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'villas': villas.map(_villaJson).toList(),
      'villa_photos': photos
          .map((ph) => {
                'id': ph.id,
                'villaId': ph.villaId,
                'filePath': photoPaths[ph.id] ?? ph.filePath,
                'sortOrder': ph.sortOrder,
              })
          .toList(),
      'villa_faqs': faqs
          .map((f) => {
                'id': f.id,
                'villaId': f.villaId,
                'question': f.question,
                'answer': f.answer,
              })
          .toList(),
      'bookings': bookings.map(_bookingJson).toList(),
      'invoices': invoices.map(_invoiceJson).toList(),
      'invoice_items': items
          .map((i) => {
                'id': i.id,
                'invoiceId': i.invoiceId,
                'description': i.description,
                'qty': i.qty,
                'price': i.price,
              })
          .toList(),
      'invoice_payments': payments
          .map((p) => {
                'id': p.id,
                'invoiceId': p.invoiceId,
                'amount': p.amount,
                'datePaid': p.datePaid.toIso8601String(),
                'paymentMethod': p.paymentMethod,
                'notes': p.notes,
              })
          .toList(),
    };

    await File(p.join(workDir.path, 'data.json'))
        .writeAsString(const JsonEncoder.withIndent('  ').convert(data));

    final zipPath =
        p.join(tmp.path, 'villamanager-backup-$stamp.zip');
    final zipFile = File(zipPath);
    if (await zipFile.exists()) await zipFile.delete();

    final encoder = ZipFileEncoder();
    encoder.create(zipPath);
    await encoder.addDirectory(workDir, includeDirName: false);
    await encoder.close();

    await workDir.delete(recursive: true);
    return zipFile;
  }

  Future<void> exportAndShare() async {
    final zip = await buildZip();
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(zip.path, mimeType: 'application/zip')],
        text: 'Backup Villa Manager',
      ),
    );
  }

  Map<String, dynamic> _villaJson(Villa v) => {
        'id': v.id,
        'name': v.name,
        'location': v.location,
        'ownerName': v.ownerName,
        'ownerContact': v.ownerContact,
        'ownerBank': v.ownerBank,
        'butlerName': v.butlerName,
        'butlerContact': v.butlerContact,
        'isButlerSameAsOwner': v.isButlerSameAsOwner,
        'isActive': v.isActive,
        'description': v.description,
        'uniqueSellingPoints': v.uniqueSellingPoints,
        'amenities': v.amenities,
        'houseRules': v.houseRules,
        'priceWeekday': v.priceWeekday,
        'priceWeekend': v.priceWeekend,
        'priceHighSeason': v.priceHighSeason,
        'commissionPercent': v.commissionPercent,
        'commissionType': v.commissionType,
        'commissionFixed': v.commissionFixed,
        'privateNotes': v.privateNotes,
        'createdAt': v.createdAt.toIso8601String(),
        'updatedAt': v.updatedAt.toIso8601String(),
      };

  Map<String, dynamic> _bookingJson(Booking b) => {
        'id': b.id,
        'villaId': b.villaId,
        'guestName': b.guestName,
        'guestContact': b.guestContact,
        'checkIn': b.checkIn.toIso8601String(),
        'checkOut': b.checkOut.toIso8601String(),
        'pricePerNightSnapshot': b.pricePerNightSnapshot,
        'status': b.status,
        'notes': b.notes,
        'createdAt': b.createdAt.toIso8601String(),
      };

  Map<String, dynamic> _invoiceJson(Invoice i) => {
        'id': i.id,
        'invoiceNumber': i.invoiceNumber,
        'bookingId': i.bookingId,
        'guestName': i.guestName,
        'villaName': i.villaName,
        'checkIn': i.checkIn.toIso8601String(),
        'checkOut': i.checkOut.toIso8601String(),
        'status': i.status,
        'dateIssued': i.dateIssued.toIso8601String(),
        'datePaid': i.datePaid?.toIso8601String(),
        'reminderSentAt': i.reminderSentAt?.toIso8601String(),
      };
}
