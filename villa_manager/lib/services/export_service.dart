import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

import '../data/database/app_database.dart';
import 'photo_storage_service.dart';

class ExportService {
  ExportService(this._db, [PhotoStorageService? storage])
    : _storage = storage ?? PhotoStorageService();

  final AppDatabase _db;
  final PhotoStorageService _storage;
  static const _maxEntryBytes = 100 * 1024 * 1024;
  static const _maxBackupBytes = 512 * 1024 * 1024;
  static const _maxArchiveEntries = 1000;

  Future<File> buildZip(String password) async {
    _validatePassword(password);
    final workDir = await Directory.systemTemp.createTemp('villapro_backup_');
    final zipFile = File('${workDir.path}.zip');

    try {
      final snapshot = await _db.transaction(
        () async => (
          villas: await _db.select(_db.villas).get(),
          photos: await _db.select(_db.villaPhotos).get(),
          faqs: await _db.select(_db.villaFaqs).get(),
          bookings: await _db.select(_db.bookings).get(),
          invoices: await _db.select(_db.invoices).get(),
          items: await _db.select(_db.invoiceItems).get(),
          payments: await _db.select(_db.invoicePayments).get(),
          settings: await _db.select(_db.appSettings).get(),
        ),
      );

      final mediaDir = Directory(p.join(workDir.path, 'media'));
      await mediaDir.create();
      final photoRows = <Map<String, dynamic>>[];
      for (final photo in snapshot.photos) {
        final row = photo.toJson();
        final source = File(photo.filePath);
        if (!await source.exists()) {
          throw StateError('Media villa tidak ditemukan: ${photo.filePath}');
        }
        if (await source.length() > _maxEntryBytes) {
          throw StateError('Media villa melebihi batas 100 MB');
        }
        final name = '${photoRows.length}${_safeExtension(photo.filePath)}';
        await source.copy(p.join(mediaDir.path, name));
        row['filePath'] = 'media/$name';
        photoRows.add(row);
      }

      final settingRows = <Map<String, dynamic>>[];
      for (final setting in snapshot.settings) {
        final row = setting.toJson();
        final logo = File(setting.logoPath);
        if (setting.logoPath.isNotEmpty) {
          if (!await logo.exists()) {
            throw StateError('Logo usaha tidak ditemukan');
          }
          if (await logo.length() > _maxEntryBytes) {
            throw StateError('Logo usaha melebihi batas 100 MB');
          }
          final ext = _safeExtension(setting.logoPath);
          final relativePath = 'branding/logo$ext';
          final destination = File(p.join(workDir.path, relativePath));
          await destination.parent.create(recursive: true);
          await logo.copy(destination.path);
          row['logoPath'] = relativePath;
        } else {
          row['logoPath'] = '';
        }
        settingRows.add(row);
      }

      final data = {
        'formatVersion': 2,
        'schemaVersion': _db.schemaVersion,
        'exportedAt': DateTime.now().toIso8601String(),
        'villas': snapshot.villas.map((row) => row.toJson()).toList(),
        'villa_photos': photoRows,
        'villa_faqs': snapshot.faqs.map((row) => row.toJson()).toList(),
        'bookings': snapshot.bookings.map((row) => row.toJson()).toList(),
        'invoices': snapshot.invoices.map((row) => row.toJson()).toList(),
        'invoice_items': snapshot.items.map((row) => row.toJson()).toList(),
        'invoice_payments': snapshot.payments
            .map((row) => row.toJson())
            .toList(),
        'app_settings': settingRows,
      };
      await File(p.join(workDir.path, 'data.json')).writeAsString(
        const JsonEncoder.withIndent('  ').convert(data),
        flush: true,
      );

      final encoder = ZipFileEncoder(password: password);
      encoder.create(zipFile.path);
      await encoder.addDirectory(workDir, includeDirName: false);
      await encoder.close();
      return zipFile;
    } catch (_) {
      if (await zipFile.exists()) await zipFile.delete();
      rethrow;
    } finally {
      if (await workDir.exists()) await workDir.delete(recursive: true);
    }
  }

  Future<void> restore(File zipFile, String password) async {
    _validatePassword(password);
    if (await zipFile.length() > _maxBackupBytes) {
      throw const FormatException('File backup melebihi batas 512 MB');
    }

    final input = InputFileStream(zipFile.path);
    try {
      final archive = ZipDecoder().decodeStream(
        input,
        password: password,
        verify: true,
      );
      try {
        _validateArchive(archive);
        final dataFile = archive.find('data.json');
        if (dataFile == null) {
          throw const FormatException('data.json tidak ada');
        }

        final decoded = jsonDecode(utf8.decode(dataFile.content));
        if (decoded is! Map<String, dynamic> || decoded['formatVersion'] != 2) {
          throw const FormatException('Format backup tidak didukung');
        }
        final schemaVersion = decoded['schemaVersion'];
        if (schemaVersion is! int ||
            schemaVersion < 1 ||
            schemaVersion > _db.schemaVersion) {
          throw const FormatException('Versi schema backup tidak didukung');
        }
        final data = decoded;

        final stagedPaths = <String>[];
        final photoRows = _rows(data, 'villa_photos');
        final settingRows = _rows(data, 'app_settings');
        var committed = false;
        try {
          for (final row in photoRows) {
            final relativePath = row['filePath'] as String? ?? '';
            if (relativePath.isEmpty) continue;
            final entry = archive.find(relativePath);
            if (entry == null || !entry.isFile) {
              throw FormatException(
                'Media backup tidak ditemukan: $relativePath',
              );
            }
            final path = await _storage.importBytes(
              entry.content,
              _safeExtension(relativePath),
            );
            stagedPaths.add(path);
            row['filePath'] = path;
          }

          for (final row in settingRows) {
            final relativePath = row['logoPath'] as String? ?? '';
            if (relativePath.isEmpty) continue;
            final entry = archive.find(relativePath);
            if (entry == null || !entry.isFile) {
              throw FormatException(
                'Logo backup tidak ditemukan: $relativePath',
              );
            }
            final path = await _storage.importBytes(
              entry.content,
              _safeExtension(relativePath),
            );
            stagedPaths.add(path);
            row['logoPath'] = path;
          }

          final oldPhotos = await _db.select(_db.villaPhotos).get();
          final oldSettings = await _db.select(_db.appSettings).get();
          await _db.transaction(() async {
            await _db.delete(_db.invoicePayments).go();
            await _db.delete(_db.invoiceItems).go();
            await _db.delete(_db.invoices).go();
            await _db.delete(_db.bookings).go();
            await _db.delete(_db.villaPhotos).go();
            await _db.delete(_db.villaFaqs).go();
            await _db.delete(_db.villas).go();
            await _db.delete(_db.appSettings).go();

            for (final row in _rows(data, 'villas')) {
              await _db.into(_db.villas).insert(Villa.fromJson(row));
            }
            for (final row in photoRows) {
              await _db.into(_db.villaPhotos).insert(VillaPhoto.fromJson(row));
            }
            for (final row in _rows(data, 'villa_faqs')) {
              await _db.into(_db.villaFaqs).insert(VillaFaq.fromJson(row));
            }
            for (final row in _rows(data, 'bookings')) {
              await _db.into(_db.bookings).insert(Booking.fromJson(row));
            }
            for (final row in _rows(data, 'invoices')) {
              await _db.into(_db.invoices).insert(Invoice.fromJson(row));
            }
            for (final row in _rows(data, 'invoice_items')) {
              await _db
                  .into(_db.invoiceItems)
                  .insert(InvoiceItem.fromJson(row));
            }
            for (final row in _rows(data, 'invoice_payments')) {
              await _db
                  .into(_db.invoicePayments)
                  .insert(InvoicePayment.fromJson(row));
            }
            for (final row in settingRows) {
              await _db.into(_db.appSettings).insert(AppSetting.fromJson(row));
            }
          });
          committed = true;

          final retained = stagedPaths.toSet();
          for (final path in [
            ...oldPhotos.map((row) => row.filePath),
            ...oldSettings.map((row) => row.logoPath),
          ]) {
            if (path.isNotEmpty && !retained.contains(path)) {
              try {
                await _storage.deleteFile(path);
              } catch (_) {}
            }
          }
        } catch (_) {
          if (!committed) {
            for (final path in stagedPaths) {
              await _storage.deleteFile(path);
            }
          }
          rethrow;
        }
      } finally {
        archive.clearSync();
      }
    } finally {
      input.closeSync();
    }
  }

  String suggestedFileName() =>
      'villapro-backup-${DateFormat('yyyyMMdd').format(DateTime.now())}.zip';

  List<Map<String, dynamic>> _rows(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is! List) throw FormatException('$key tidak valid');
    return value.map((row) => Map<String, dynamic>.from(row as Map)).toList();
  }

  void _validateArchive(Archive archive) {
    if (archive.length > _maxArchiveEntries) {
      throw const FormatException('Backup memiliki terlalu banyak file');
    }
    var expandedBytes = 0;
    for (final entry in archive) {
      final normalized = p.posix.normalize(entry.name);
      if (p.posix.isAbsolute(entry.name) ||
          normalized == '..' ||
          normalized.startsWith('../')) {
        throw const FormatException('Path file backup tidak valid');
      }
      if (!entry.isFile) continue;
      if (entry.size < 0 || entry.size > _maxEntryBytes) {
        throw const FormatException('File dalam backup melebihi batas 100 MB');
      }
      expandedBytes += entry.size;
      if (expandedBytes > _maxBackupBytes) {
        throw const FormatException('Isi backup melebihi batas 512 MB');
      }
    }
  }

  String _safeExtension(String path) {
    final extension = p.extension(path).toLowerCase();
    return RegExp(r'^\.[a-z0-9]{1,8}$').hasMatch(extension)
        ? extension
        : '.bin';
  }

  void _validatePassword(String password) {
    if (password.trim().length < 12) {
      throw ArgumentError('Password backup minimal 12 karakter');
    }
  }
}
