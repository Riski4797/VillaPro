import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class PhotoStorageService {
  static const _uuid = Uuid();

  Future<Directory> _dir() async {
    final root = await getApplicationDocumentsDirectory();
    final d = Directory(p.join(root.path, 'villa_photos'));
    if (!await d.exists()) await d.create(recursive: true);
    return d;
  }

  /// Copy picked gallery file into app storage; returns new absolute path.
  Future<String> importPhoto(String sourcePath) async {
    final dir = await _dir();
    final ext = p.extension(sourcePath).isEmpty ? '.jpg' : p.extension(sourcePath);
    final dest = File(p.join(dir.path, '${_uuid.v4()}$ext'));
    await File(sourcePath).copy(dest.path);
    return dest.path;
  }

  Future<void> deleteFile(String path) async {
    final f = File(path);
    if (await f.exists()) await f.delete();
  }
}
