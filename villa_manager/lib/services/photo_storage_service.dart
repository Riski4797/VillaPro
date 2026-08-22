import 'dart:io';
import 'dart:isolate';

import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class PhotoStorageService {
  PhotoStorageService([this._root]);

  final Directory? _root;
  static const _uuid = Uuid();
  static const _maxImageBytes = 30 * 1024 * 1024;
  static const _maxMediaBytes = 100 * 1024 * 1024;

  Future<Directory> _dir() async {
    final root = _root ?? await getApplicationSupportDirectory();
    final d = Directory(p.join(root.path, 'villa_media'));
    if (!await d.exists()) await d.create(recursive: true);
    return d;
  }

  /// Copy picked gallery file into app storage; returns new absolute path.
  Future<String> importPhoto(
    String sourcePath, {
    bool optimizeImage = true,
  }) async {
    final source = File(sourcePath);
    final maxBytes = optimizeImage ? _maxImageBytes : _maxMediaBytes;
    if (await source.length() > maxBytes) {
      throw ArgumentError(
        optimizeImage
            ? 'Ukuran gambar maksimal 30 MB'
            : 'Ukuran video maksimal 100 MB',
      );
    }
    final dir = await _dir();
    final sourceExtension = p.extension(sourcePath).toLowerCase();
    final ext = optimizeImage
        ? (sourceExtension == '.png' ? '.png' : '.jpg')
        : (sourceExtension.isEmpty ? '.bin' : sourceExtension);
    final dest = File(p.join(dir.path, '${_uuid.v4()}$ext'));
    if (!optimizeImage) {
      await source.copy(dest.path);
      return dest.path;
    }

    final encoded = await Isolate.run(() {
      final decoded = img.decodeImage(File(sourcePath).readAsBytesSync());
      if (decoded == null) throw const FormatException('Gambar tidak valid');
      var output = decoded;
      if (decoded.width > 2048 || decoded.height > 2048) {
        output = decoded.width >= decoded.height
            ? img.copyResize(decoded, width: 2048)
            : img.copyResize(decoded, height: 2048);
      }
      return sourceExtension == '.png'
          ? img.encodePng(output)
          : img.encodeJpg(output, quality: 88);
    });
    await dest.writeAsBytes(encoded, flush: true);
    return dest.path;
  }

  Future<String> importBytes(List<int> bytes, String extension) async {
    if (bytes.length > _maxMediaBytes) {
      throw ArgumentError('Ukuran media maksimal 100 MB');
    }
    final dir = await _dir();
    final ext = extension.startsWith('.') ? extension : '.$extension';
    final dest = File(p.join(dir.path, '${_uuid.v4()}$ext'));
    await dest.writeAsBytes(bytes, flush: true);
    return dest.path;
  }

  Future<void> deleteFile(String path) async {
    final f = File(path);
    if (await f.exists()) await f.delete();
  }
}
