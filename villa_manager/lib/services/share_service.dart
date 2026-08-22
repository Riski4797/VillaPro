import 'dart:io';

import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as p;

import '../core/utils/message_templates.dart';
import '../data/database/app_database.dart';
import '../data/repositories/invoice_repository.dart';
import 'pdf_service.dart';

class ShareService {
  Future<void> shareVilla({
    required Villa villa,
    required ShareTemplate template,
    required List<VillaPhoto> photos,
    String? customText,
    AppSetting? settings,
  }) async {
    final text = customText?.trim().isNotEmpty ?? false
        ? customText!.trim()
        : villaShareText(villa, template, settings);

    if (photos.isEmpty) {
      await shareTextOnly(text);
      return;
    }
    if (Platform.isLinux) {
      throw UnsupportedError('Berbagi file hanya tersedia pada Android');
    }
    final files = photos
        .map((ph) => XFile(ph.filePath))
        .where((f) => File(f.path).existsSync())
        .toList();
    if (files.isEmpty) {
      await shareTextOnly(text);
      return;
    }
    await SharePlus.instance.share(ShareParams(text: text, files: files));
  }

  Future<void> shareTextOnly(String text) async {
    if (Platform.isLinux) {
      await Clipboard.setData(ClipboardData(text: text));
      return;
    }
    await SharePlus.instance.share(ShareParams(text: text));
  }

  Future<void> shareInvoice(
    InvoiceDetail detail, [
    AppSetting? settings,
  ]) async {
    final text = invoiceShareText(detail, settings);
    if (Platform.isLinux) {
      throw UnsupportedError('Berbagi invoice hanya tersedia pada Android');
    }
    final bytes = await PdfService().buildBytes(detail, settings);
    final dir = await Directory.systemTemp.createTemp('villapro_invoice_');
    try {
      final safeNumber = detail.invoice.invoiceNumber.replaceAll(
        RegExp(r'[^A-Za-z0-9_.-]'),
        '_',
      );
      final file = File('${dir.path}/${p.basename(safeNumber)}.pdf');
      await file.writeAsBytes(bytes, flush: true);
      await SharePlus.instance.share(
        ShareParams(
          text: text,
          files: [XFile(file.path, mimeType: 'application/pdf')],
        ),
      );
    } finally {
      if (await dir.exists()) await dir.delete(recursive: true);
    }
  }
}
