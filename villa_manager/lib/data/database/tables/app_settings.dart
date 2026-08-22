import 'package:drift/drift.dart';

class AppSettings extends Table {
  TextColumn get id => text().withDefault(const Constant('default'))();
  TextColumn get businessName =>
      text().withDefault(const Constant('Villa Management & Reservations'))();
  TextColumn get tagline =>
      text().withDefault(const Constant('GUEST FOLIO & OFFICIAL INVOICE'))();
  TextColumn get logoPath => text().withDefault(const Constant(''))();
  TextColumn get adminName => text().withDefault(const Constant('Admin'))();
  TextColumn get adminContact => text().withDefault(const Constant(''))();
  TextColumn get bankAccounts => text().withDefault(const Constant(
      '- BCA: 123-456-7890 a.n. Villa Manager\n- Mandiri: 987-654-3210 a.n. Villa Manager'))();
  TextColumn get invoiceFooterNote => text().withDefault(const Constant(
      'Harap simpan bukti pembayaran dan tunjukkan saat proses check-in.'))();
  TextColumn get templateTeaser => text().withDefault(const Constant(
      '{nama_villa} - {lokasi}\nHarga mulai {harga_weekday}/malam\n{keunggulan}\nMau info lengkap? Chat aja ya kak 🙏'))();
  TextColumn get templateDetail => text().withDefault(const Constant(
      '*{nama_villa}*\n📍 {lokasi}\n\n{deskripsi}\n\n✨ *Keunggulan:*\n{keunggulan}\n\n🏠 *Fasilitas:*\n{fasilitas}\n\n💰 *Tarif Sewa:*\n- Weekday: {harga_weekday}/malam\n- Weekend: {harga_weekend}/malam\n- High season: {harga_high_season}/malam\n\n📋 *Aturan Menginap:*\n{aturan}\n\nInfo booking & ketersediaan:\nHubungi {nama_admin} ({kontak_admin})'))();
  TextColumn get templateButlerNotification => text().withDefault(const Constant(
      'Halo {nama_penjaga}, ada tamu yang akan check-in:\n• Villa: {nama_villa}\n• Tamu: {nama_tamu} ({kontak_tamu})\n• Jadwal: {tgl_checkin} s.d {tgl_checkout} ({jumlah_malam} malam)\nMohon dibantu persiapan villa & kunci ya. Terima kasih 🙏'))();

  @override
  Set<Column> get primaryKey => {id};
}
