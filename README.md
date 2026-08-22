# 🌴 VillaPro - Villa Manager

Aplikasi manajemen operasional & pemasaran villa offline-first untuk marketer freelance dan property manager.

Dibangun menggunakan **Flutter (Android & Linux Desktop)** dengan arsitektur **Riverpod** dan database lokal **Drift SQLite**.

---

## ✨ Fitur Utama

- 🏡 **Katalog & Manajemen Villa:**
  - Database lengkap: USP, fasilitas, aturan rumah, catatan rahasia owner, dan komisi marketer.
  - Multi-media: Galeri foto dan video tour villa offline.
  - Status ketersediaan realtime (🟢 *Tersedia Hari Ini* / 🔴 *Terisi s.d [Tanggal]*).
  - Smart Villa Matcher (filter instan tanggal kosong + budget + area).
  - Fitur salin data dari villa lain.

- 📅 **Manajemen Booking & Kalender:**
  - Deteksi bentrok tanggal (*overlap check*) otomatis antar reservasi.
  - Filter fase menginap (Semua, Akan Datang, Berlangsung, Selesai, Batal).
  - Tombol 1-klik kirim info tamu ke penjaga villa via WhatsApp.

- 💰 **Sistem Invoice & Pembayaran Bertahap:**
  - Pembayaran bertahap: Catat DP (Down Payment) dan Pelunasan.
  - Kalkulasi otomatis total tagihan, DP masuk, dan sisa tagihan (*balance due*).
  - Export PDF **Guest Folio** mewah dengan stempel status (*LUNAS / DP DITERIMA / BELUM LUNAS*), rincian DP, rekening transfer, dan logo usaha.
  - Tombol 1-klik *"Tandai Langsung Lunas"*.

- 💬 **Kustomisasi Pesan WhatsApp:**
  - Editor template teks WA dengan Live Preview realtime di Pengaturan.
  - Kotak edit pesan sebelum kirim ke customer.

- 📄 **Brosur & Katalog PDF:**
  - Brosur flyer A4 single villa (bersih dari data owner & komisi).
  - Buku katalog multi-villa dari hasil filter pencarian.

- 📊 **Dashboard & Laporan Komisi:**
  - Ringkasan KPI dan jadwal check-in 7 hari mendatang.
  - Laporan omzet & komisi marketer (bulan berjalan, pilih bulan, atau rentang kustom).

- 🔒 **100% Offline-First & Keamanan Data:**
  - Penyimpanan lokal penuh tanpa ketergantungan server cloud eksternal.
  - Export cadangan data ke file ZIP (`villamanager-backup-YYYYMMDD.zip`).

---

## 🛠️ Tech Stack

- **Framework:** Flutter 3.47+ (Dart 3.13+)
- **State Management:** `flutter_riverpod`
- **Database:** `drift` + `sqlite3_flutter_libs`
- **Routing:** `go_router`
- **PDF & Printing:** `pdf` + `printing`
- **Media & Sharing:** `image_picker`, `share_plus`
- **Typography & Theme:** `google_fonts` (Plus Jakarta Sans) - *Warm Bali Resort & Linen Theme*
- **Notifications:** `flutter_local_notifications`

---

## 🚀 Menjalankan Aplikasi

### Desktop Linux (Local Test)
```bash
cd villa_manager
flutter pub get
dart run build_runner build
flutter run -d linux
```

### Build APK Android Release
```bash
cd villa_manager
flutter build apk --release --split-per-abi
```

File APK akan tersedia di `build/app/outputs/flutter-apk/`.

---

## 📄 Lisensi
Private / Proprietary. Dikembangkan untuk efisiensi kerja marketer freelance villa.
