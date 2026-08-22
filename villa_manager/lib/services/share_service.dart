import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

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
      await SharePlus.instance.share(ShareParams(text: text));
      return;
    }
    final files = photos
        .map((ph) => XFile(ph.filePath))
        .where((f) => File(f.path).existsSync())
        .toList();
    await SharePlus.instance.share(ShareParams(text: text, files: files));
  }

  Future<void> shareTextOnly(String text) async {
    await SharePlus.instance.share(ShareParams(text: text));
  }

  Future<void> shareInvoice(InvoiceDetail detail,
      [AppSetting? settings]) async {
    final text = invoiceShareText(detail, settings);
    final bytes = await PdfService().buildBytes(detail, settings);
    final dir = await getTemporaryDirectory();
    final path = p.join(dir.path, '${detail.invoice.invoiceNumber}.pdf');
    await File(path).writeAsBytes(bytes);
    await SharePlus.instance.share(
      ShareParams(
          text: text, files: [XFile(path, mimeType: 'application/pdf')]),
    );
  }
}
