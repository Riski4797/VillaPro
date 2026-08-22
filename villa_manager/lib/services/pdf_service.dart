import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../core/utils/booking_utils.dart';
import '../core/utils/formatters.dart';
import '../data/database/app_database.dart';
import '../data/repositories/invoice_repository.dart';

class PdfService {
  Future<void> exportInvoice(InvoiceDetail detail,
      [AppSetting? settings]) async {
    final bytes = await buildBytes(detail, settings);
    await Printing.layoutPdf(
      onLayout: (_) async => bytes,
      name: detail.invoice.invoiceNumber,
    );
  }

  Future<Uint8List> buildBytes(InvoiceDetail detail,
          [AppSetting? settings]) =>
      _build(detail, settings).save();

  String _clean(String s) {
    return s
        .replaceAll('—', '-')
        .replaceAll('–', '-')
        .replaceAll('•', '-')
        .replaceAll('“', '"')
        .replaceAll('”', '"')
        .replaceAll('‘', "'")
        .replaceAll('’', "'")
        .replaceAll('…', '...')
        .replaceAll('→', 's.d.')
        .replaceAll('←', '<-');
  }

  pw.Document _build(InvoiceDetail detail, [AppSetting? settings]) {
    final inv = detail.invoice;
    final nights = nightsBetween(inv.checkIn, inv.checkOut);
    final status = detail.effectiveStatus; // 'paid', 'partial', 'unpaid'
    final doc = pw.Document();

    final businessName = (settings?.businessName.isNotEmpty ?? false)
        ? settings!.businessName.toUpperCase()
        : 'VILLA MANAGEMENT & RESERVATIONS';
    final tagline = (settings?.tagline.isNotEmpty ?? false)
        ? settings!.tagline.toUpperCase()
        : 'GUEST FOLIO & OFFICIAL INVOICE';
    final bankInfo = (settings?.bankAccounts.isNotEmpty ?? false)
        ? settings!.bankAccounts.replaceAll('•', '-')
        : '- BCA: 123-456-7890 a.n. Villa Manager\n- Mandiri: 987-654-3210 a.n. Villa Manager';
    final footerNote = (settings?.invoiceFooterNote.isNotEmpty ?? false)
        ? settings!.invoiceFooterNote
        : 'Harap simpan bukti pembayaran dan tunjukkan saat proses check-in.';

    const primaryColor = PdfColor.fromInt(0xFF1B5E20); // Forest Green
    const goldColor = PdfColor.fromInt(0xFF8D6E63);
    const darkText = PdfColor.fromInt(0xFF212121);
    const lightBg = PdfColor.fromInt(0xFFF9FBF9);

    pw.MemoryImage? logoImage;
    if (settings != null && settings.logoPath.isNotEmpty) {
      final logoFile = File(settings.logoPath);
      if (logoFile.existsSync()) {
        try {
          logoImage = pw.MemoryImage(logoFile.readAsBytesSync());
        } catch (_) {}
      }
    }

    final (stampBg, stampBorder, stampText, stampLabel) = switch (status) {
      'paid' => (
          const PdfColor.fromInt(0xFFE8F5E9),
          const PdfColor.fromInt(0xFF2E7D32),
          const PdfColor.fromInt(0xFF1B5E20),
          'LUNAS / FULLY PAID'
        ),
      'partial' => (
          const PdfColor.fromInt(0xFFFFF8E1),
          const PdfColor.fromInt(0xFFF57F17),
          const PdfColor.fromInt(0xFFE65100),
          'DP DITERIMA / PARTIALLY PAID'
        ),
      _ => (
          const PdfColor.fromInt(0xFFFFEBEE),
          const PdfColor.fromInt(0xFFC62828),
          const PdfColor.fromInt(0xFFB71C1C),
          'BELUM LUNAS / UNPAID'
        ),
    };

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 36, vertical: 32),
        build: (ctx) => [
          // Header Bar
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  if (logoImage != null) ...[
                    pw.Container(
                      width: 42,
                      height: 42,
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
                        _clean(businessName),
                        style: pw.TextStyle(
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold,
                          color: primaryColor,
                          letterSpacing: 1.1,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        _clean(tagline),
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
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    _clean(inv.invoiceNumber),
                    style: const pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: darkText,
                    ),
                  ),
                  pw.SizedBox(height: 2),
                  pw.Text(
                    'Tanggal: ${formatDate(inv.dateIssued)}',
                    style: const pw.TextStyle(
                      fontSize: 9,
                      color: PdfColors.grey700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Divider(color: primaryColor, thickness: 1.5),
          pw.SizedBox(height: 14),

          // Reservation & Guest Information Box
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: lightBg,
              borderRadius: pw.BorderRadius.circular(6),
              border: pw.Border.all(color: PdfColors.grey300),
            ),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'INFORMASI TAMU',
                        style: const pw.TextStyle(
                          fontSize: 9,
                          fontWeight: pw.FontWeight.bold,
                          color: goldColor,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        _clean(inv.guestName),
                        style: const pw.TextStyle(
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold,
                          color: darkText,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text('Villa: ${_clean(inv.villaName)}',
                          style: const pw.TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
                pw.Container(
                  width: 1,
                  height: 45,
                  color: PdfColors.grey300,
                  margin: const pw.EdgeInsets.symmetric(horizontal: 16),
                ),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'DETAIL MENGINAP',
                        style: const pw.TextStyle(
                          fontSize: 9,
                          fontWeight: pw.FontWeight.bold,
                          color: goldColor,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        '${formatDate(inv.checkIn)}  s.d.  ${formatDate(inv.checkOut)}',
                        style: const pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text('Durasi: $nights Malam',
                          style: const pw.TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 18),

          // Items Table
          pw.Text(
            'RINCIAN BIAYA (CHARGES)',
            style: const pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
              color: primaryColor,
              letterSpacing: 0.5,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.TableHelper.fromTextArray(
            headers: ['Deskripsi Layanan', 'Qty', 'Harga Satuan', 'Subtotal'],
            data: detail.items
                .map((i) => [
                      _clean(i.description),
                      '${i.qty}',
                      formatCurrency(i.price),
                      formatCurrency(i.qty * i.price),
                    ])
                .toList(),
            headerStyle: const pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
            headerDecoration: const pw.BoxDecoration(color: primaryColor),
            headerPadding:
                const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            cellPadding:
                const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            cellStyle: const pw.TextStyle(fontSize: 9),
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerRight,
              2: pw.Alignment.centerRight,
              3: pw.Alignment.centerRight,
            },
          ),
          pw.SizedBox(height: 14),

          // Payments Table (if any)
          if (detail.payments.isNotEmpty) ...[
            pw.Text(
              'PEMBAYARAN DITERIMA (PAYMENTS RECEIVED)',
              style: const pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: primaryColor,
                letterSpacing: 0.5,
              ),
            ),
            pw.SizedBox(height: 6),
            pw.TableHelper.fromTextArray(
              headers: ['Tanggal', 'Metode', 'Keterangan', 'Jumlah Dibayar'],
              data: detail.payments
                  .map((p) => [
                        formatDate(p.datePaid),
                        _clean(p.paymentMethod),
                        p.notes.isEmpty ? '-' : _clean(p.notes),
                        formatCurrency(p.amount),
                      ])
                  .toList(),
              headerStyle: const pw.TextStyle(
                fontSize: 9,
                fontWeight: pw.FontWeight.bold,
                color: darkText,
              ),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey200),
              headerPadding:
                  const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              cellPadding:
                  const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              cellStyle: const pw.TextStyle(fontSize: 9),
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                2: pw.Alignment.centerLeft,
                3: pw.Alignment.centerRight,
              },
            ),
            pw.SizedBox(height: 14),
          ],

          // Summary & Stamp Box
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              // Stamp & Status Badge
              pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: pw.BoxDecoration(
                  color: stampBg,
                  borderRadius: pw.BorderRadius.circular(6),
                  border: pw.Border.all(color: stampBorder, width: 1.5),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      stampLabel,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        color: stampText,
                        letterSpacing: 0.8,
                      ),
                    ),
                    if (status == 'partial') ...[
                      pw.SizedBox(height: 3),
                      pw.Text(
                        'Telah diterima: ${formatCurrency(detail.paidAmount)}',
                        style: pw.TextStyle(fontSize: 9, color: stampText),
                      ),
                    ],
                  ],
                ),
              ),

              // Total Calculation Summary
              pw.Container(
                width: 210,
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  color: lightBg,
                  borderRadius: pw.BorderRadius.circular(6),
                  border: pw.Border.all(color: PdfColors.grey300),
                ),
                child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Total Tagihan:',
                            style: const pw.TextStyle(fontSize: 10)),
                        pw.Text(formatCurrency(detail.total),
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    pw.SizedBox(height: 4),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Sudah Dibayar (DP):',
                            style: const pw.TextStyle(
                                fontSize: 10, color: PdfColors.green800)),
                        pw.Text(formatCurrency(detail.paidAmount),
                            style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.green800)),
                      ],
                    ),
                    pw.Divider(color: PdfColors.grey400, height: 10),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('SISA TAGIHAN:',
                            style: pw.TextStyle(
                                fontSize: 11,
                                fontWeight: pw.FontWeight.bold,
                                color: detail.remainingBalance > 0
                                    ? PdfColors.red800
                                    : primaryColor)),
                        pw.Text(
                          formatCurrency(detail.remainingBalance),
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                            color: detail.remainingBalance > 0
                                ? PdfColors.red800
                                : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          pw.SizedBox(height: 24),

          // Bank Payment Details (Clean border box without non-standard icon font)
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: lightBg,
              border: pw.Border.all(color: PdfColors.grey300, width: 0.8),
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'INFORMASI PEMBAYARAN TRANSFER BANK',
                  style: const pw.TextStyle(
                    fontSize: 9,
                    fontWeight: pw.FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  bankInfo,
                  style: const pw.TextStyle(
                    fontSize: 9,
                    color: darkText,
                    lineSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 24),

          // Footer
          pw.Center(
            child: pw.Column(
              children: [
                pw.Text(
                  'Terima kasih atas reservasi dan kepercayaan Anda.',
                  style: pw.TextStyle(
                    fontSize: 9,
                    fontWeight: pw.FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  footerNote,
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
    );
    return doc;
  }
}
