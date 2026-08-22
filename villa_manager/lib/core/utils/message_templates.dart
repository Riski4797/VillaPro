import '../../data/database/app_database.dart';
import '../../data/repositories/invoice_repository.dart';
import '../../data/repositories/villa_repository.dart';
import 'booking_utils.dart';
import 'formatters.dart';

enum ShareTemplate { teaser, detail, priceList }

String villaShareText(Villa v, ShareTemplate kind, [AppSetting? settings]) {
  final usps = VillaRepository.decodeList(v.uniqueSellingPoints);
  final amenities = VillaRepository.decodeList(v.amenities);
  final weekday = formatCurrency(v.priceWeekday);
  final weekend = formatCurrency(v.priceWeekend);
  final highSeason = formatCurrency(v.priceHighSeason);
  final adminName = settings?.adminName ?? 'Admin';
  final adminContact = settings?.adminContact ?? '';

  String interpolate(String template) {
    return template
        .replaceAll('{nama_villa}', v.name)
        .replaceAll('{lokasi}', v.location)
        .replaceAll('{deskripsi}', v.description)
        .replaceAll('{keunggulan}', usps.map((e) => '• $e').join('\n'))
        .replaceAll('{fasilitas}', amenities.map((e) => '• $e').join('\n'))
        .replaceAll('{aturan}', v.houseRules)
        .replaceAll('{harga_weekday}', weekday)
        .replaceAll('{harga_weekend}', weekend)
        .replaceAll('{harga_high_season}', highSeason)
        .replaceAll('{nama_admin}', adminName)
        .replaceAll('{kontak_admin}', adminContact);
  }

  return switch (kind) {
    ShareTemplate.teaser => () {
        if (settings != null && settings.templateTeaser.isNotEmpty) {
          return interpolate(settings.templateTeaser);
        }
        final uspLine = usps.take(2).join(', ');
        return '${v.name} - ${v.location}\n'
            'Harga mulai $weekday/malam\n'
            '${uspLine.isEmpty ? '' : '$uspLine\n'}'
            'Mau info lengkap? Chat aja ya kak 🙏';
      }(),
    ShareTemplate.detail => () {
        if (settings != null && settings.templateDetail.isNotEmpty) {
          return interpolate(settings.templateDetail);
        }
        final uspBlock = usps.isEmpty
            ? ''
            : '✨ *Keunggulan:*\n${usps.map((e) => '• $e').join('\n')}\n\n';
        final amBlock = amenities.isEmpty
            ? ''
            : '🏠 *Fasilitas:*\n${amenities.map((e) => '• $e').join('\n')}\n\n';
        final rules =
            v.houseRules.isEmpty ? '' : '📋 *Aturan Menginap:*\n${v.houseRules}\n\n';
        return '*${v.name}*\n'
            '📍 ${v.location}\n\n'
            '${v.description.isEmpty ? '' : '${v.description}\n\n'}'
            '$uspBlock'
            '$amBlock'
            '💰 *Tarif Sewa:*\n'
            '- Weekday: $weekday/malam\n'
            '- Weekend: $weekend/malam\n'
            '- High season: $highSeason/malam\n\n'
            '$rules'
            'Info booking & ketersediaan:\n'
            'Hubungi $adminName ($adminContact)';
      }(),
    ShareTemplate.priceList => '*${v.name}*\n'
        'Weekday: $weekday | '
        'Weekend: $weekend | '
        'High season: $highSeason',
  };
}

String butlerNotificationText({
  required Villa villa,
  required Booking booking,
  AppSetting? settings,
}) {
  final nights = nightsBetween(booking.checkIn, booking.checkOut);
  final butlerName =
      villa.butlerName.isNotEmpty ? villa.butlerName : 'Penjaga Villa';

  if (settings != null && settings.templateButlerNotification.isNotEmpty) {
    return settings.templateButlerNotification
        .replaceAll('{nama_penjaga}', butlerName)
        .replaceAll('{nama_villa}', villa.name)
        .replaceAll('{nama_tamu}', booking.guestName)
        .replaceAll('{kontak_tamu}', booking.guestContact)
        .replaceAll('{tgl_checkin}', formatDate(booking.checkIn))
        .replaceAll('{tgl_checkout}', formatDate(booking.checkOut))
        .replaceAll('{jumlah_malam}', '$nights');
  }

  return 'Halo $butlerName, ada tamu yang akan check-in:\n'
      '• Villa: ${villa.name}\n'
      '• Tamu: ${booking.guestName} (${booking.guestContact})\n'
      '• Jadwal: ${formatDate(booking.checkIn)} s.d ${formatDate(booking.checkOut)} ($nights malam)\n\n'
      'Mohon dibantu persiapan villa & kunci ya. Terima kasih 🙏';
}

String invoiceShareText(InvoiceDetail detail, [AppSetting? settings]) {
  final inv = detail.invoice;
  final status = detail.statusLabel;
  final headerTitle = (settings?.businessName.isNotEmpty ?? false)
      ? settings!.businessName.toUpperCase()
      : 'INVOICE RESERVASI VILLA';
  final bankInfo = (settings?.bankAccounts.isNotEmpty ?? false)
      ? settings!.bankAccounts
      : '• BCA: 123-456-7890 a.n. Villa Manager\n• Mandiri: 987-654-3210 a.n. Villa Manager';

  final buffer = StringBuffer();
  buffer.writeln('📋 *$headerTitle*');
  buffer.writeln('No: *${inv.invoiceNumber}*');
  buffer.writeln('Tamu: ${inv.guestName}');
  buffer.writeln('Villa: ${inv.villaName}');
  buffer.writeln('Jadwal: ${formatDate(inv.checkIn)} → ${formatDate(inv.checkOut)}');
  buffer.writeln('---------------------------');
  buffer.writeln('Total Tagihan: *${formatCurrency(detail.total)}*');
  if (detail.paidAmount > 0) {
    buffer.writeln('Sudah Dibayar (DP): ${formatCurrency(detail.paidAmount)}');
    buffer.writeln('Sisa Tagihan: *${formatCurrency(detail.remainingBalance)}*');
  }
  buffer.writeln('Status: *[$status]*');
  buffer.writeln('---------------------------');
  buffer.writeln('Informasi Rekening Transfer:');
  buffer.writeln(bankInfo);
  buffer.write('Terima kasih 🙏');
  return buffer.toString();
}
