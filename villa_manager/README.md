# Villa Manager

Offline Flutter app for villa marketers. Spec: `../villa-manager-blueprint.md`.

## Current (Fase 1–9 — v1 complete)

- Villa CRUD + foto + FAQ + salin dari villa lain + Bagikan ke Customer
- Booking CRUD + filter fase + validasi bentrok tanggal
- Invoice dari booking, item, lunas, PDF, kirim WA
- Dashboard + Laporan omzet/komisi
- Notifikasi check-in H-1 + reminder invoice unpaid >3 hari
- Backup ZIP (`villamanager-backup-YYYYMMDD.zip`) via share sheet
- Bottom nav: Dashboard | Villa | Booking | Invoice

## Out of v1

- Import dari backup
- Grafik `fl_chart`
- Cloud sync / multi-user / iOS focus

## Run

```bash
export PATH="$HOME/sdk/flutter/bin:$PATH"
cd villa_manager
flutter pub get
dart run build_runner build
flutter run   # -d linux | android device
```
