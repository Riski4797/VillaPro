# Blueprint: Villa Manager (Flutter, Android)

Dokumen ini adalah spesifikasi teknis untuk AI coding agent membangun aplikasi dari nol. Semua keputusan scope sudah final — ikuti dokumen ini sebagai sumber kebenaran tunggal (single source of truth).

## 1. Ringkasan Produk

**Pengguna**: satu orang marketer villa yang memasarkan villa milik banyak owner berbeda ke wisatawan (mayoritas domestik).

**Masalah yang diselesaikan**:
1. Sulit mengingat detail (harga, fasilitas, USP) puluhan villa saat chat dengan calon tamu
2. Perlu cara cepat mengirim info villa yang rapi ke WhatsApp tanpa ngetik ulang
3. Perlu mencatat booking & membuat invoice tanpa Excel manual
4. Perlu tahu total pendapatan/komisi tanpa hitung manual

**Prinsip desain sistem**:
- 100% offline, single-user, tanpa backend/server
- Semua data & foto disimpan lokal di device
- Tidak ada sinkronisasi cloud otomatis — backup dilakukan manual oleh user lewat fitur export
- Platform target: Android

## 2. Tech Stack

| Kebutuhan | Package |
|---|---|
| State management | `flutter_riverpod` |
| Database lokal | `drift` (di atas native assets `sqlite3`) |
| Notifikasi lokal | `flutter_local_notifications` |
| Share ke WhatsApp (teks+gambar) | `share_plus` |
| Generate PDF | `pdf` + `printing` |
| Ambil foto dari galeri | `image_picker` |
| Path direktori aplikasi | `path_provider`, `path` |
| Export/compress data | `archive` (untuk buat file zip) |
| ID unik | `uuid` |
| Format tanggal & mata uang (IDR) | `intl` |
| Routing | `go_router` |

## 3. Struktur Folder

```
lib/
  main.dart
  core/
    theme/            // ThemeData, color tokens, text styles
    constants/
    utils/             // formatCurrency, formatDate, dateRangeOverlap()
  data/
    database/
      app_database.dart      // drift database class
      tables/                // VillaTable, VillaPhotoTable, BookingTable, InvoiceTable, InvoiceItemTable
    repositories/
      villa_repository.dart
      booking_repository.dart
      invoice_repository.dart
      report_repository.dart
  features/
    dashboard/
    villa/
      villa_list_screen.dart
      villa_detail_screen.dart
      villa_form_screen.dart
      share_to_customer_sheet.dart
    booking/
      booking_list_screen.dart
      booking_form_screen.dart
    invoice/
      invoice_list_screen.dart
      invoice_detail_screen.dart
    report/
      report_screen.dart
    settings/
      export_data_screen.dart   // backup manual
  services/
    notification_service.dart
    pdf_service.dart
    share_service.dart
    export_service.dart
```

## 4. Skema Database (Drift)

### Table: `villas`
| Kolom | Tipe | Keterangan |
|---|---|---|
| id | text, PK | uuid |
| name | text | |
| location | text | |
| owner_name | text | |
| owner_contact | text | |
| is_active | bool | default true; villa nonaktif disembunyikan dari katalog aktif tapi tidak dihapus |
| description | text | |
| unique_selling_points | text | disimpan JSON array of string |
| amenities | text | disimpan JSON array of string |
| house_rules | text | |
| price_weekday | int | rupiah |
| price_weekend | int | rupiah |
| price_high_season | int | rupiah |
| commission_percent | real | untuk perhitungan laporan |
| private_notes | text | tidak pernah ikut ke template share |
| created_at | datetime | |
| updated_at | datetime | |

### Table: `villa_photos`
| Kolom | Tipe | Keterangan |
|---|---|---|
| id | text, PK | |
| villa_id | text, FK -> villas.id | |
| file_path | text | path lokal di app storage (foto dicopy dari galeri ke direktori app, bukan hanya referensi) |
| sort_order | int | |

### Table: `villa_faqs`
| Kolom | Tipe |
|---|---|
| id | text, PK |
| villa_id | text, FK |
| question | text |
| answer | text |

### Table: `bookings`
| Kolom | Tipe | Keterangan |
|---|---|---|
| id | text, PK | |
| villa_id | text, FK | |
| guest_name | text | |
| guest_contact | text | nomor WA, dinormalisasi ke format 62xxx saat disimpan |
| check_in | date | |
| check_out | date | |
| price_per_night_snapshot | int | harga disepakati saat booking dibuat, independen dari perubahan harga villa di masa depan |
| status | text enum | `confirmed` \| `cancelled` |
| notes | text | |
| created_at | datetime | |

### Table: `invoices`
| Kolom | Tipe | Keterangan |
|---|---|---|
| id | text, PK | |
| invoice_number | text | format `INV-YYYYMM-NNN` |
| booking_id | text, FK | |
| guest_name | text | snapshot dari booking |
| villa_name | text | snapshot |
| check_in | date | |
| check_out | date | |
| status | text enum | `unpaid` \| `paid` |
| date_issued | date | |
| date_paid | date, nullable | |
| reminder_sent_at | datetime, nullable | untuk tracking reminder tunggakan |

### Table: `invoice_items`
| Kolom | Tipe |
|---|---|
| id | text, PK |
| invoice_id | text, FK |
| description | text |
| qty | int |
| price | int |

**Relasi**: `villas` 1—N `villa_photos`, `villas` 1—N `villa_faqs`, `villas` 1—N `bookings`, `bookings` 1—1 `invoices` (opsional, booking bisa belum punya invoice), `invoices` 1—N `invoice_items`.

## 5. Modul & Layar

### 5.1 Dashboard
- Kartu ringkasan: jumlah villa aktif, jumlah booking berjalan (status confirmed, checkOut >= hari ini)
- Kartu total invoice belum dibayar (jumlah + total rupiah)
- List "Check-in mendatang" (7 hari ke depan, urut tanggal)
- Tap kartu invoice → navigasi ke tab Invoice terfilter unpaid

### 5.2 Villa (Katalog & Product Knowledge)
**List screen**:
- Toggle filter: Aktif / Semua
- Search by nama/lokasi
- Tiap card: foto thumbnail, nama, lokasi, harga weekday, badge nonaktif jika `is_active = false`

**Detail screen** (tab internal dalam satu halaman):
- Tab "Info": deskripsi, USP, harga bertingkat
- Tab "Foto": grid galeri, tombol tambah/hapus foto
- Tab "Fasilitas & Aturan": checklist amenities, house rules
- Tab "FAQ": list tanya-jawab, tambah/edit/hapus
- Tab "Catatan Pribadi": owner contact, komisi %, catatan bebas — **beri label visual jelas "tidak terlihat customer"**
- Tombol utama: **"Bagikan ke Customer"**

**Form tambah/edit villa**:
- Semua field di atas
- Tombol **"Salin dari villa lain"**: pilih villa existing, semua field ter-copy ke form baru (kecuali nama & foto), lalu user edit yang beda
- Toggle status aktif/nonaktif

**Alur "Bagikan ke Customer"** (bottom sheet):
1. Pilih jenis template: `Teaser Singkat` / `Detail Lengkap` / `Price List`
2. Preview teks (generated, lihat §8 untuk format)
3. Pilih foto dari galeri villa (multi-select, default: foto pertama)
4. Tombol "Bagikan" → panggil `Share.shareXFiles(photos, text: generatedText)` dari `share_plus` → sistem share sheet muncul, user pilih WhatsApp/kontak

### 5.3 Booking
**List screen**:
- Filter chip: Semua / Akan Datang / Berlangsung / Selesai / Batal
- Status dihitung otomatis dari tanggal (bukan disimpan sebagai field statis kecuali `cancelled`)
- Tiap card: nama villa, nama tamu, tanggal, total harga, tombol "Buat Invoice" (disembunyikan jika sudah ada invoice utk booking ini)

**Form tambah/edit booking**:
- Pilih villa (dropdown) → auto-isi `price_per_night_snapshot` dari harga villa (editable manual untuk harga nego)
- Nama tamu, kontak WA
- Tanggal check-in & check-out (date picker)
- **Validasi bentrok tanggal**: sebelum simpan, query semua booking lain dengan `villa_id` sama dan `status = confirmed` yang rentang tanggalnya overlap (`newCheckIn < existing.checkOut AND newCheckOut > existing.checkIn`). Jika ada bentrok, tampilkan dialog peringatan berisi nama tamu & tanggal yang bentrok, dengan pilihan "Tetap Simpan" (override manual) atau "Batal"

### 5.4 Invoice
**List screen**:
- Search by nama tamu/nomor invoice
- Tiap card: nomor invoice, nama tamu, villa, total, status badge

**Detail screen**:
- Tampilan invoice (nomor, villa, tamu, tanggal, rincian item, total)
- Tambah item baris baru (mis. biaya antar-jemput)
- Toggle status lunas/belum
- Tombol **"Export PDF"** → generate file PDF (lihat §7) → buka print/share dialog dari package `printing`
- Tombol **"Kirim WhatsApp"** → share teks + PDF (atau teks+foto villa) via `share_plus`
- Tombol hapus invoice

### 5.5 Laporan
- Filter periode: bulan berjalan / pilih bulan lain / rentang custom
- Ringkasan: Total Omzet (jumlah semua invoice lunas dalam periode), Total Komisi (`sum(invoice_total * villa.commission_percent / 100)` untuk invoice lunas)
- Breakdown per villa: tabel villa, jumlah booking, omzet, komisi
- (Opsional, nice-to-have) grafik batang omzet per bulan pakai `fl_chart` — boleh di-skip di v1 kalau agent ingin scope minimal

## 6. Reminder / Notifikasi Lokal

Gunakan `flutter_local_notifications` dengan dua mekanisme berbeda karena sifat triggernya beda:

**A. Reminder check-in (H-1)**
- Dijadwalkan (`zonedSchedule`) tepat saat booking baru dibuat/diedit, untuk waktu `checkIn - 1 hari, jam 09:00`
- Jika booking diedit/dihapus, notifikasi lama untuk booking tsb harus di-cancel dan dijadwalkan ulang (simpan `notification_id` terkait booking, misal hash dari booking id)
- Isi notifikasi: "Besok check-in: {guestName} di {villaName}"

**B. Reminder invoice belum dibayar**
- Karena status invoice bisa berubah kapan saja (tidak bisa dijadwalkan presisi jauh-jauh hari), gunakan pendekatan: setiap kali app dibuka (di `main.dart` / dashboard init), jalankan pengecekan invoice dengan `status = unpaid` dan `date_issued` lebih dari **3 hari** yang lalu dan `reminder_sent_at` masih null atau lebih dari 3 hari lalu → tampilkan notifikasi lokal langsung (immediate, bukan scheduled) + update `reminder_sent_at`
- Tambahan: badge count di tab Invoice untuk invoice overdue, sebagai fallback kalau app jarang dibuka

## 7. Format PDF Invoice (`pdf_service.dart`)

Struktur halaman PDF (A4, gunakan package `pdf`):
1. Header: nama usaha (dari Settings/hardcode dulu), nomor invoice, tanggal terbit
2. Info tamu & villa: nama tamu, nama villa, check-in/check-out, jumlah malam
3. Tabel item: deskripsi, qty, harga satuan, subtotal
4. Total di baris bawah, dibold/besar
5. Status LUNAS/BELUM LUNAS ditampilkan jelas (bisa pakai warna hijau/merah)
6. Footer: ucapan terima kasih

## 8. Template Pesan (untuk fitur Bagikan ke Customer)

**Teaser Singkat**:
```
{villaName} - {location}
{jumlah kamar jika ada di description/amenities} kamar, harga mulai {priceWeekday}/malam
{1-2 USP pertama}
Mau info lengkap? Chat aja 🙏
```

**Detail Lengkap**:
```
*{villaName}*
📍 {location}

{description}

✨ Keunggulan:
{list USP dengan bullet}

🏠 Fasilitas:
{list amenities dengan bullet}

💰 Harga:
- Weekday: {priceWeekday}/malam
- Weekend: {priceWeekend}/malam
- High season: {priceHighSeason}/malam

📋 {houseRules}
```

**Price List** (versi ringkas untuk perbandingan cepat):
```
*{villaName}*
Weekday: {priceWeekday} | Weekend: {priceWeekend} | High season: {priceHighSeason}
```

Semua template dibuat sebagai fungsi murni di `core/utils/message_templates.dart` yang menerima objek `Villa` dan mengembalikan `String`, agar mudah diuji dan diedit terpisah dari UI.

## 9. Export/Backup Manual (`export_service.dart`)

- Tombol di Settings: "Export Semua Data"
- Proses: serialize semua tabel (villas, villa_photos, villa_faqs, bookings, invoices, invoice_items) ke JSON, copy semua file foto ke folder sementara, compress semuanya jadi satu file `.zip` (nama file: `villamanager-backup-YYYYMMDD.zip`) pakai package `archive`
- Setelah zip terbentuk, panggil `share_plus` supaya user bisa simpan ke Google Drive/kirim ke email sendiri, dll (bukan auto-upload — hanya membuka opsi simpan)
- Restore dari backup terenkripsi dilakukan melalui menu Settings; tidak ada sinkronisasi cloud otomatis.

## 10. Non-Functional Requirements

- Semua operasi database harus bisa jalan tanpa koneksi internet
- Tidak ada dependency ke API eksternal apapun (termasuk untuk maps — cukup simpan lokasi sebagai teks bebas, tidak perlu geocoding)
- Format mata uang: Rupiah, `id_ID` locale, tanpa desimal
- Format tanggal: `id_ID` locale (mis. "15 Agu 2026")
- Bahasa UI: Bahasa Indonesia

## 11. Di Luar Cakupan (v1)

- Multi-user / akses tim
- Sinkronisasi cloud otomatis
- Payment gateway / pembayaran online
- Multi-bahasa (Inggris dll)
- iOS (fokus Android dulu meski Flutter cross-platform)

## 12. Rencana Implementasi Bertahap

Urutan ini dirancang supaya tiap fase menghasilkan sesuatu yang bisa dites/dijalankan:

1. **Fase 1** — Setup project, skema database (drift), CRUD Villa dasar (tanpa foto/FAQ dulu)
2. **Fase 2** — Foto villa (image_picker + storage lokal), FAQ, USP, amenities, status aktif/nonaktif, fitur "Salin dari villa lain"
3. **Fase 3** — Booking CRUD + validasi bentrok tanggal
4. **Fase 4** — Invoice CRUD (generate dari booking, tambah item, tandai lunas)
5. **Fase 5** — Export PDF invoice
6. **Fase 6** — Fitur "Bagikan ke Customer" (template teks + share foto) dan share invoice ke WA
7. **Fase 7** — Dashboard + Laporan komisi
8. **Fase 8** — Notifikasi (reminder check-in H-1, reminder invoice nunggak)
9. **Fase 9** — Export/backup manual data ke zip

---

*Catatan untuk agent coding: setiap keputusan desain visual (warna, tipografi) tidak dispesifikasikan ketat di dokumen ini — gunakan Material 3 sebagai basis, dan bisa merujuk ke referensi versi web app sebelumnya (tema gelap hijau-tropis dengan aksen emas, invoice bergaya "guest folio" kertas terang) sebagai inspirasi opsional, bukan requirement wajib.*
