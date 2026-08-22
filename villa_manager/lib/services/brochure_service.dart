import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../core/utils/formatters.dart';
import '../data/database/app_database.dart';
import '../data/repositories/villa_repository.dart';

class BrochureService {
  Future<void> exportSingleVillaBrochure({
    required Villa villa,
    required List<VillaPhoto> photos,
    AppSetting? settings,
  }) async {
    final bytes =
        await buildSingleVillaBytes(villa: villa, photos: photos, settings: settings);
    await Printing.layoutPdf(
      onLayout: (_) async => bytes,
      name: 'Brosur-${villa.name.replaceAll(' ', '_')}.pdf',
    );
  }

  Future<Uint8List> buildSingleVillaBytes({
    required Villa villa,
    required List<VillaPhoto> photos,
    AppSetting? settings,
  }) async {
    final doc = pw.Document();
    final usps = VillaRepository.decodeList(villa.uniqueSellingPoints);
    final amenities = VillaRepository.decodeList(villa.amenities);

    final agencyName = (settings?.businessName.isNotEmpty ?? false)
        ? settings!.businessName.toUpperCase()
        : 'VILLA MANAGEMENT & RESERVATIONS';
    final adminContact = (settings?.adminContact.isNotEmpty ?? false)
        ? '${settings!.adminName} (${settings.adminContact})'
        : 'Admin Reservasi';

    const primaryColor = PdfColor.fromInt(0xFF0E3D30); // Forest Emerald
    const goldColor = PdfColor.fromInt(0xFFC5A059);
    const lightBg = PdfColor.fromInt(0xFFF9FBF9);

    // Load photo images into memory
    final loadedImages = <pw.MemoryImage>[];
    for (final ph in photos.take(5)) {
      final f = File(ph.filePath);
      if (f.existsSync()) {
        try {
          loadedImages.add(pw.MemoryImage(f.readAsBytesSync()));
        } catch (_) {}
      }
    }

    // Load logo image if set
    pw.MemoryImage? logoImage;
    if (settings != null && settings.logoPath.isNotEmpty) {
      final logoFile = File(settings.logoPath);
      if (logoFile.existsSync()) {
        try {
          logoImage = pw.MemoryImage(logoFile.readAsBytesSync());
        } catch (_) {}
      }
    }

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 36, vertical: 32),
        build: (ctx) => [
          // Header Brand
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  if (logoImage != null) ...[
                    pw.Container(
                      width: 38,
                      height: 38,
                      margin: const pw.EdgeInsets.only(right: 10),
                      child: pw.ClipRRect(
                        horizontalRadius: 6,
                        verticalRadius: 6,
                        child: pw.Image(logoImage, fit: pw.BoxFit.contain),
                      ),
                    ),
                  ],
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        agencyName,
                        style: pw.TextStyle(
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold,
                          color: primaryColor,
                          letterSpacing: 1.2,
                        ),
                      ),
                      pw.Text(
                        'EXCLUSIVE VILLA COLLECTION',
                        style: const pw.TextStyle(
                          fontSize: 8.5,
                          color: PdfColors.grey700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: pw.BoxDecoration(
                  color: primaryColor,
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Text(
                  'OFFICIAL BROCHURE',
                  style: pw.TextStyle(
                    fontSize: 8.5,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Divider(color: primaryColor, thickness: 1.5),
          pw.SizedBox(height: 12),

          // Main Photo Banner or Photo Gallery Grid
          if (loadedImages.isNotEmpty) ...[
            pw.Container(
              height: 200,
              width: double.infinity,
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.ClipRRect(
                horizontalRadius: 8,
                verticalRadius: 8,
                child: pw.Image(loadedImages.first, fit: pw.BoxFit.cover),
              ),
            ),
            if (loadedImages.length > 1) ...[
              pw.SizedBox(height: 8),
              pw.Row(
                children: loadedImages.skip(1).take(4).map((img) {
                  return pw.Expanded(
                    child: pw.Container(
                      height: 70,
                      margin: const pw.EdgeInsets.symmetric(horizontal: 2),
                      child: pw.ClipRRect(
                        horizontalRadius: 4,
                        verticalRadius: 4,
                        child: pw.Image(img, fit: pw.BoxFit.cover),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            pw.SizedBox(height: 16),
          ],

          // Title & Location
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      villa.name,
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (villa.location.isNotEmpty) ...[
                      pw.SizedBox(height: 2),
                      pw.Text(
                        'Lokasi: ${villa.location}',
                        style: const pw.TextStyle(
                          fontSize: 11,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                decoration: pw.BoxDecoration(
                  color: lightBg,
                  borderRadius: pw.BorderRadius.circular(6),
                  border: pw.Border.all(color: primaryColor, width: 1),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'Mulai dari',
                      style: const pw.TextStyle(
                        fontSize: 8.5,
                        color: PdfColors.grey700,
                      ),
                    ),
                    pw.Text(
                      formatCurrency(villa.priceWeekday),
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    pw.Text(
                      '/ malam',
                      style: const pw.TextStyle(
                        fontSize: 8,
                        color: PdfColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          pw.SizedBox(height: 14),

          // Description
          if (villa.description.isNotEmpty) ...[
            pw.Text(
              villa.description,
              style: const pw.TextStyle(fontSize: 9.5, lineSpacing: 2),
            ),
            pw.SizedBox(height: 14),
          ],

          // Highlights & USPs
          if (usps.isNotEmpty) ...[
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                color: lightBg,
                borderRadius: pw.BorderRadius.circular(6),
                border: pw.Border.all(color: PdfColors.grey300),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'KEUNGGULAN UTAMA',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                      color: goldColor,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Wrap(
                    spacing: 12,
                    runSpacing: 4,
                    children: usps
                        .map((u) => pw.Text('- $u',
                            style: const pw.TextStyle(fontSize: 9)))
                        .toList(),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 14),
          ],

          // Amenities List
          if (amenities.isNotEmpty) ...[
            pw.Text(
              'FASILITAS VILLA',
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: primaryColor,
              ),
            ),
            pw.SizedBox(height: 6),
            pw.Wrap(
              spacing: 8,
              runSpacing: 6,
              children: amenities.map((a) {
                return pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
                    borderRadius: pw.BorderRadius.circular(4),
                    border: pw.Border.all(color: PdfColors.grey300),
                  ),
                  child: pw.Text('- $a',
                      style: const pw.TextStyle(fontSize: 8.5)),
                );
              }).toList(),
            ),
            pw.SizedBox(height: 14),
          ],

          // Price Breakdown Table
          pw.Text(
            'TARIF SEWA LENGKAP',
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
              color: primaryColor,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.TableHelper.fromTextArray(
            headers: ['Periode Menginap', 'Harga Publish / Malam'],
            data: [
              ['Hari Kerja (Weekday)', formatCurrency(villa.priceWeekday)],
              ['Akhir Pekan (Weekend)', formatCurrency(villa.priceWeekend)],
              [
                'Musim Liburan (High Season)',
                formatCurrency(villa.priceHighSeason)
              ],
            ],
            headerStyle: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
            headerDecoration: const pw.BoxDecoration(color: primaryColor),
            headerPadding:
                const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            cellPadding:
                const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            cellStyle: const pw.TextStyle(fontSize: 9),
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerRight,
            },
          ),

          pw.SizedBox(height: 18),

          // Inquiries & Booking Contact Box
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              color: primaryColor,
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Tertarik untuk Reservasi / Tanya Ketersediaan?',
                      style: pw.TextStyle(
                        fontSize: 9.5,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.SizedBox(height: 2),
                    pw.Text(
                      'Hubungi $adminContact',
                      style: const pw.TextStyle(
                        fontSize: 8.5,
                        color: PdfColors.grey200,
                      ),
                    ),
                  ],
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: pw.BoxDecoration(
                    color: goldColor,
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Text(
                    'BOOK NOW',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return doc.save();
  }

  Future<void> exportMultiVillaCatalog({
    required List<Villa> villas,
    required Map<String, String?> photoPaths,
    AppSetting? settings,
  }) async {
    final doc = pw.Document();
    final agencyName = (settings?.businessName.isNotEmpty ?? false)
        ? settings!.businessName.toUpperCase()
        : 'VILLA MANAGEMENT & RESERVATIONS';
    final adminContact = (settings?.adminContact.isNotEmpty ?? false)
        ? '${settings!.adminName} (${settings.adminContact})'
        : 'Admin Reservasi';

    const primaryColor = PdfColor.fromInt(0xFF0E3D30);

    for (final v in villas) {
      final usps = VillaRepository.decodeList(v.uniqueSellingPoints);
      final amenities = VillaRepository.decodeList(v.amenities);
      final photoPath = photoPaths[v.id];
      pw.MemoryImage? memImg;
      if (photoPath != null && File(photoPath).existsSync()) {
        try {
          memImg = pw.MemoryImage(File(photoPath).readAsBytesSync());
        } catch (_) {}
      }

      doc.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 36, vertical: 32),
          build: (ctx) => [
            // Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  agencyName,
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                pw.Text(
                  'KATALOG VILLA PILIHAN',
                  style: const pw.TextStyle(
                    fontSize: 9,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
            ),
            pw.Divider(color: primaryColor, thickness: 1),
            pw.SizedBox(height: 10),

            if (memImg != null) ...[
              pw.Container(
                height: 180,
                width: double.infinity,
                child: pw.ClipRRect(
                  horizontalRadius: 6,
                  verticalRadius: 6,
                  child: pw.Image(memImg, fit: pw.BoxFit.cover),
                ),
              ),
              pw.SizedBox(height: 12),
            ],

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        v.name,
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      if (v.location.isNotEmpty)
                        pw.Text('Lokasi: ${v.location}',
                            style: const pw.TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
                pw.Text(
                  '${formatCurrency(v.priceWeekday)} / mlm',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 8),

            if (v.description.isNotEmpty) ...[
              pw.Text(v.description, style: const pw.TextStyle(fontSize: 9)),
              pw.SizedBox(height: 10),
            ],

            if (usps.isNotEmpty) ...[
              pw.Text('Keunggulan: ${usps.join(" · ")}',
                  style: pw.TextStyle(
                      fontSize: 9, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),
            ],

            if (amenities.isNotEmpty) ...[
              pw.Text('Fasilitas: ${amenities.take(8).join(", ")}',
                  style: const pw.TextStyle(fontSize: 9)),
              pw.SizedBox(height: 12),
            ],

            pw.Divider(color: PdfColors.grey300),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Kontak Reservasi: $adminContact',
                    style: const pw.TextStyle(fontSize: 8.5)),
                pw.Text(
                    'Weekend: ${formatCurrency(v.priceWeekend)} · High Season: ${formatCurrency(v.priceHighSeason)}',
                    style: const pw.TextStyle(fontSize: 8.5)),
              ],
            ),
          ],
        ),
      );
    }

    final bytes = await doc.save();
    await Printing.layoutPdf(
      onLayout: (_) async => bytes,
      name: 'Katalog_Pilihan_Villa.pdf',
    );
  }
}
