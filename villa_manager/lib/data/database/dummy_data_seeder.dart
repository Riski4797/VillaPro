import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../database/app_database.dart';
import '../repositories/booking_repository.dart';
import '../repositories/invoice_repository.dart';
import '../repositories/settings_repository.dart';
import '../repositories/villa_repository.dart';

class DummyDataSeeder {
  static Future<void> seedIfEmpty(AppDatabase db,
      [Directory? customPhotoDir]) async {
    final existing = await db.select(db.villas).get();
    if (existing.isNotEmpty) return; // already has data

    final villaRepo = VillaRepository(db);
    final bookingRepo = BookingRepository(db);
    final invoiceRepo = InvoiceRepository(db);
    final settingsRepo = SettingsRepository(db);

    // 1. Seed Settings / Profile
    await settingsRepo.updateSettings(
      businessName: 'Bali Sanctuary Villa Management',
      tagline: 'LUXURY RETREATS & RESORT CONCIERGE',
      adminName: 'Riski (Marketer)',
      adminContact: '6281234567890',
      bankAccounts:
          '• BCA: 772-019-8822 a.n. Bali Sanctuary\n• Mandiri: 142-00-9988771 a.n. Bali Sanctuary\n• QRIS: Scan QRIS Bali Sanctuary',
      invoiceFooterNote:
          'Harap transfer DP 50% untuk mengunci tanggal. Pelunasan dilakukan saat proses check-in.',
    );

    // 2. Generate aesthetic dummy photo files
    final photoDir = customPhotoDir ?? await _getPhotoDirectory();
    final bambooPhoto1 =
        await _createSampleImage(photoDir, 'bamboo_main.png', 0xFF0E3D30, 'VILLA ASMARA UBUD');
    final bambooPhoto2 =
        await _createSampleImage(photoDir, 'bamboo_pool.png', 0xFF1B5E4A, 'INFINITY POOL');
    final palmsPhoto1 =
        await _createSampleImage(photoDir, 'palms_main.png', 0xFF0A2E24, 'THE PALMS CANGGU');
    final palmsPhoto2 =
        await _createSampleImage(photoDir, 'palms_deck.png', 0xFFC5A059, 'SUNSET ROOFTOP');
    final casaPhoto1 =
        await _createSampleImage(photoDir, 'casa_main.png', 0xFF1F4E5B, 'CASA BLANCA ULUWATU');
    final oasisPhoto1 =
        await _createSampleImage(photoDir, 'oasis_main.png', 0xFF2D5A47, 'SEMINYAK OASIS');

    // 3. Seed Villa 1: Villa Asmara (Ubud)
    final v1Id = await villaRepo.upsert(
      name: 'Villa Asmara Bamboo Sanctuary',
      location: 'Jl. Raya Sayan, Ubud, Gianyar, Bali',
      description:
          'Villa bambu eco-luxury 3 kamar dengan pemandangan lembah sawah terasering dan sungai Ayung. Dilengkapi kolam renang air hangat alami, dapur terbuka, dan gazebo yoga pribadi.',
      usps: [
        'Infinity Pool Menghadap Lembah Sayan',
        '100% Eco Bamboo Architecture Eksklusif',
        'Sunset & Sunrise Ricefield View',
        'Floating Breakfast & Afternoon Tea Termasuk',
      ],
      amenities: [
        '3 Kamar Tidur Suite AC',
        'Private Infinity Pool',
        'High Speed WiFi 100 Mbps',
        'Open-Air Kitchen & Dining',
        'Outdoor Bathtub View Lembah',
        'Daily Housekeeping',
        'BBQ Grill Set',
      ],
      houseRules:
          'Dilarang merokok di dalam kamar, Musik santai diperbolehkan hingga pukul 22:00, Kapasitas maksimum 6 orang dewasa.',
      priceWeekday: 2800000,
      priceWeekend: 3200000,
      priceHighSeason: 4500000,
      commissionType: 'percent',
      commissionPercent: 10.0,
      ownerName: 'Pak Ketut Suardana',
      ownerContact: '6281234567801',
      ownerBank: 'BCA 7720192831 a.n. I Ketut Suardana',
      butlerName: 'Bli Kadek',
      butlerContact: '6281999888111',
      isButlerSameAsOwner: false,
      privateNotes:
          'Kunci ada di Bli Kadek, owner sangat ramah. Komisi dibayar 1x24 jam setelah tamu check-out.',
    );
    await _insertPhoto(db, v1Id, bambooPhoto1.path, 0);
    await _insertPhoto(db, v1Id, bambooPhoto2.path, 1);
    await villaRepo.upsertFaq(
      villaId: v1Id,
      question: 'Apakah harga sudah termasuk sarapan?',
      answer: 'Ya, sudah termasuk sarapan ala carte / floating breakfast untuk 6 orang.',
    );
    await villaRepo.upsertFaq(
      villaId: v1Id,
      question: 'Berapa jarak ke pusat Ubud (Ubud Center)?',
      answer: 'Hanya 10-12 menit berkendara ke Monkey Forest dan Puri Saren Ubud.',
    );

    // 4. Seed Villa 2: The Palms (Canggu)
    final v2Id = await villaRepo.upsert(
      name: 'The Palms Oceanfront Estate',
      location: 'Jl. Pantai Batu Bolong, Canggu, Badung, Bali',
      description:
          'Villa modern tropis 4 kamar hanya 2 menit jalan kaki ke Pantai Batu Bolong. Dilengkapi rooftop sunset bar, private pool 12 meter, dan smart home sound system.',
      usps: [
        '2 Menit Jalan Kaki ke Pantai Batu Bolong',
        'Rooftop Sunset Lounge & Bar Pribadi',
        'Private Pool 12 Meter',
        'Bisa Disewa Bulanan / Long-Term',
      ],
      amenities: [
        '4 Kamar Suite King Bed',
        'Private Pool 12m',
        'Rooftop Bar & Lounge',
        'Smart TV 65 Inch + Netflix',
        'Sonos Sound System',
        'Security 24 Jam',
        'Garasi 2 Mobil',
      ],
      houseRules:
          'Check-in 14:00, Check-out 11:00, Dilarang membawa hewan peliharaan, No smoking indoor.',
      priceWeekday: 5500000,
      priceWeekend: 6200000,
      priceHighSeason: 8000000,
      commissionType: 'fixed',
      commissionFixed: 500000,
      ownerName: 'Bu Jessica Lim',
      ownerContact: '628118822334',
      ownerBank: 'Mandiri 1420019283741 a.n. Jessica Lim',
      isButlerSameAsOwner: true,
      privateNotes: 'Owner handle langsung operasional & serah terima kunci.',
    );
    await _insertPhoto(db, v2Id, palmsPhoto1.path, 0);
    await _insertPhoto(db, v2Id, palmsPhoto2.path, 1);

    // 5. Seed Villa 3: Casa Blanca (Uluwatu)
    final v3Id = await villaRepo.upsert(
      name: 'Casa Blanca Cliffside Retreat',
      location: 'Jl. Pantai Bingin, Pecatu, Uluwatu, Bali',
      description:
          'Villa mediterania serba putih di atas tebing Bingin dengan panorama Samudra Hindia 180 derajat. Spot terbaik menikmati sunset spektakuler Uluwatu.',
      usps: [
        '180° Ocean View & Sunset Tebing Bingin',
        'Akses Jalan Kaki Langsung ke Pantai',
        'Desain Mediterania Santorini Mewah',
        'Cocok untuk Honeymoon & Private Gatherings',
      ],
      amenities: [
        '2 Kamar Suite View Laut',
        'Cliffside Infinity Pool',
        'Bathtub Panoramic View',
        'Nespresso Coffee Machine',
        'Marshall Bluetooth Speaker',
        'Butler On-Call 24 Jam',
      ],
      houseRules:
          'Dilarang pesta musik kencang setelah 22:00, Anak-anak wajib dalam pengawasan di area tebing.',
      priceWeekday: 3800000,
      priceWeekend: 4400000,
      priceHighSeason: 5900000,
      commissionType: 'percent',
      commissionPercent: 12.5,
      ownerName: 'Pak Made Artha',
      ownerContact: '6281338877665',
      ownerBank: 'BCA 0401928374 a.n. I Made Artha',
      butlerName: 'Wayan Gede',
      butlerContact: '6287888999000',
      isButlerSameAsOwner: false,
      privateNotes: 'Bisa nego diskon 5% jika tamu sewa lebih dari 5 malam.',
    );
    await _insertPhoto(db, v3Id, casaPhoto1.path, 0);

    // 6. Seed Villa 4: Villa Seminyak Oasis
    final v4Id = await villaRepo.upsert(
      name: 'Villa Seminyak Tropical Oasis',
      location: 'Jl. Kayu Aya (Oberoi), Seminyak, Bali',
      description:
          'Oase tropis tersembunyi di pusat Seminyak. Bersebelahan dengan restoran ternama dan beach club, namun tetap tenang dan damai untuk liburan keluarga.',
      usps: [
        'Lokasi Premium Pusat Kuliner Seminyak',
        'Taman Tropis Luas & Sangat Private',
        'Dekat Pantai Seminyak (7 Menit)',
      ],
      amenities: [
        '2 Kamar Tidur AC',
        'Private Swimming Pool',
        'Full Kitchen & Kulkas 2 Pintu',
        'Cleaning Harian',
        'Fast WiFi',
      ],
      houseRules: 'No smoking in bedroom. Check-in 14:00.',
      priceWeekday: 1950000,
      priceWeekend: 2300000,
      priceHighSeason: 3100000,
      commissionType: 'fixed',
      commissionFixed: 200000,
      ownerName: 'Ibu Cindy Wijaya',
      ownerContact: '628177665544',
      ownerBank: 'BCA 8890123456 a.n. Cindy Wijaya',
      butlerName: 'Pak Nyoman',
      butlerContact: '6285237890123',
      isButlerSameAsOwner: false,
      privateNotes: 'Owner tinggal di Surabaya, kunci di Pak Nyoman.',
    );
    await _insertPhoto(db, v4Id, oasisPhoto1.path, 0);

    // 7. Seed Bookings & Invoices
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Booking 1: ONGOING HARI INI (The Palms) -> Lunas
    final b1Id = await bookingRepo.upsert(
      villaId: v2Id,
      guestName: 'Michael & Sarah (Australia)',
      guestContact: '6281298765432',
      checkIn: today.subtract(const Duration(days: 1)),
      checkOut: today.add(const Duration(days: 3)),
      pricePerNightSnapshot: 5500000,
      status: 'confirmed',
      notes: 'Honeymoon couple, request wine & extra towels.',
    );
    final inv1Id = await invoiceRepo.createFromBooking(
      booking: (await bookingRepo.getById(b1Id))!,
      villaName: 'The Palms Oceanfront Estate',
    );
    // Add full payments (DP 50% + Pelunasan)
    await invoiceRepo.addPayment(
      invoiceId: inv1Id,
      amount: 11000000,
      datePaid: today.subtract(const Duration(days: 7)),
      paymentMethod: 'Transfer Bank',
      notes: 'DP 50% via BCA',
    );
    await invoiceRepo.addPayment(
      invoiceId: inv1Id,
      amount: 11000000,
      datePaid: today.subtract(const Duration(days: 1)),
      paymentMethod: 'Transfer Bank',
      notes: 'Pelunasan H-1 Check-in',
    );

    // Booking 2: UPCOMING DP MASUK (Villa Asmara)
    final b2Id = await bookingRepo.upsert(
      villaId: v1Id,
      guestName: 'Dr. Hendra Gunawan & Family',
      guestContact: '6281809988776',
      checkIn: today.add(const Duration(days: 2)),
      checkOut: today.add(const Duration(days: 5)),
      pricePerNightSnapshot: 2800000,
      status: 'confirmed',
      notes: 'Keluarga 5 orang. Request 1 extra bed.',
    );
    final inv2Id = await invoiceRepo.createFromBooking(
      booking: (await bookingRepo.getById(b2Id))!,
      villaName: 'Villa Asmara Bamboo Sanctuary',
    );
    await invoiceRepo.addItem(
      invoiceId: inv2Id,
      description: 'Extra Bed Mattress (3 malam)',
      qty: 1,
      price: 350000,
    );
    await invoiceRepo.addItem(
      invoiceId: inv2Id,
      description: 'Floating Breakfast Experience',
      qty: 1,
      price: 250000,
    );
    // Paid 50% DP (Total is 2.800.000 * 3 + 350.000 + 250.000 = 9.000.000)
    await invoiceRepo.addPayment(
      invoiceId: inv2Id,
      amount: 4500000,
      datePaid: today.subtract(const Duration(days: 2)),
      paymentMethod: 'Transfer Bank',
      notes: 'DP 50% (Sisa 4.5jt bayar saat check-in)',
    );

    // Booking 3: UPCOMING UNPAID (Casa Blanca)
    final b3Id = await bookingRepo.upsert(
      villaId: v3Id,
      guestName: 'Jessica Tan (Jakarta)',
      guestContact: '6281122334455',
      checkIn: today.add(const Duration(days: 6)),
      checkOut: today.add(const Duration(days: 9)),
      pricePerNightSnapshot: 3800000,
      status: 'confirmed',
      notes: 'Tamu ulang tahun, butuh airport transfer.',
    );
    await invoiceRepo.createFromBooking(
      booking: (await bookingRepo.getById(b3Id))!,
      villaName: 'Casa Blanca Cliffside Retreat',
    );

    // Booking 4: SELESAI (Seminyak Oasis)
    final b4Id = await bookingRepo.upsert(
      villaId: v4Id,
      guestName: 'Rizky Ramadhan',
      guestContact: '6281344556677',
      checkIn: today.subtract(const Duration(days: 10)),
      checkOut: today.subtract(const Duration(days: 7)),
      pricePerNightSnapshot: 1950000,
      status: 'confirmed',
      notes: 'Transaksi lancar.',
    );
    final inv4Id = await invoiceRepo.createFromBooking(
      booking: (await bookingRepo.getById(b4Id))!,
      villaName: 'Villa Seminyak Tropical Oasis',
    );
    await invoiceRepo.addPayment(
      invoiceId: inv4Id,
      amount: 1950000 * 3,
      datePaid: today.subtract(const Duration(days: 10)),
      paymentMethod: 'Transfer Bank',
      notes: 'Lunas di awal',
    );
  }

  static Future<Directory> _getPhotoDirectory() async {
    final root = await getApplicationDocumentsDirectory();
    final d = Directory(p.join(root.path, 'villa_photos'));
    if (!await d.exists()) await d.create(recursive: true);
    return d;
  }

  static Future<void> _insertPhoto(
      AppDatabase db, String villaId, String path, int sortOrder) async {
    await db.into(db.villaPhotos).insert(
          VillaPhotosCompanion(
            id: Value('${villaId}_photo_$sortOrder'),
            villaId: Value(villaId),
            filePath: Value(path),
            sortOrder: Value(sortOrder),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  /// Creates a valid PNG sample image with custom solid background color
  static Future<File> _createSampleImage(
      Directory dir, String filename, int hexColor, String label) async {
    final file = File(p.join(dir.path, filename));
    if (await file.exists()) return file;

    // Generate a clean 600x380 PNG bitmap in pure Dart (without heavy libs)
    final pngBytes = _generateSolidPng(600, 380, hexColor);
    await file.writeAsBytes(pngBytes);
    return file;
  }

  /// Minimal uncompressed valid PNG generator in pure Dart
  static Uint8List _generateSolidPng(int width, int height, int argb) {
    final r = (argb >> 16) & 0xFF;
    final g = (argb >> 8) & 0xFF;
    final b = argb & 0xFF;

    // PNG signature
    final header = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A];

    // IHDR chunk
    final ihdrData = ByteData(13)
      ..setUint32(0, width)
      ..setUint32(4, height)
      ..setUint8(8, 8) // bit depth
      ..setUint8(9, 2) // color type: truecolor (RGB)
      ..setUint8(10, 0) // compression
      ..setUint8(11, 0) // filter
      ..setUint8(12, 0); // interlace
    final ihdrChunk = _makeChunk('IHDR', ihdrData.buffer.asUint8List());

    // Raw uncompressed scanlines: each scanline starts with filter byte 0x00, followed by RGB
    final rawScanlines = BytesBuilder();
    for (var y = 0; y < height; y++) {
      rawScanlines.addByte(0); // filter: None
      // Subtle gradient effect based on row
      final factor = 1.0 - (y / height) * 0.25;
      final gr = (r * factor).round().clamp(0, 255);
      final gg = (g * factor).round().clamp(0, 255);
      final gb = (b * factor).round().clamp(0, 255);

      for (var x = 0; x < width; x++) {
        rawScanlines.add([gr, gg, gb]);
      }
    }

    // zlib wrapper around uncompressed deflate blocks
    final raw = rawScanlines.toBytes();
    final zlibStream = BytesBuilder();
    zlibStream.add([0x78, 0x01]); // zlib header: deflate, no dict

    // Deflate uncompressed blocks (max 65535 bytes per block)
    var pos = 0;
    while (pos < raw.length) {
      final remaining = raw.length - pos;
      final blockSize = remaining > 65535 ? 65535 : remaining;
      final isFinal = (pos + blockSize) >= raw.length;

      zlibStream.addByte(isFinal ? 0x01 : 0x00);
      zlibStream.addByte(blockSize & 0xFF);
      zlibStream.addByte((blockSize >> 8) & 0xFF);
      final nlen = (~blockSize) & 0xFFFF;
      zlibStream.addByte(nlen & 0xFF);
      zlibStream.addByte((nlen >> 8) & 0xFF);
      zlibStream.add(raw.sublist(pos, pos + blockSize));
      pos += blockSize;
    }

    // Adler-32 checksum
    final adler = _adler32(raw);
    final adlerBytes = ByteData(4)..setUint32(0, adler);
    zlibStream.add(adlerBytes.buffer.asUint8List());

    final idatChunk = _makeChunk('IDAT', zlibStream.toBytes());
    final iendChunk = _makeChunk('IEND', Uint8List(0));

    final builder = BytesBuilder();
    builder.add(header);
    builder.add(ihdrChunk);
    builder.add(idatChunk);
    builder.add(iendChunk);
    return builder.toBytes();
  }

  static List<int> _makeChunk(String type, Uint8List data) {
    final typeBytes = type.codeUnits;
    final length = data.length;

    final builder = BytesBuilder();
    final lenBytes = ByteData(4)..setUint32(0, length);
    builder.add(lenBytes.buffer.asUint8List());
    builder.add(typeBytes);
    builder.add(data);

    final crcData = BytesBuilder()
      ..add(typeBytes)
      ..add(data);
    final crc = _crc32(crcData.toBytes());
    final crcBytes = ByteData(4)..setUint32(0, crc);
    builder.add(crcBytes.buffer.asUint8List());
    return builder.toBytes();
  }

  static int _adler32(Uint8List data) {
    var a = 1;
    var b = 0;
    const mod = 65521;
    for (var i = 0; i < data.length; i++) {
      a = (a + data[i]) % mod;
      b = (b + a) % mod;
    }
    return (b << 16) | a;
  }

  static final List<int> _crcTable = () {
    final table = List<int>.filled(256, 0);
    for (var i = 0; i < 256; i++) {
      var c = i;
      for (var j = 0; j < 8; j++) {
        if ((c & 1) != 0) {
          c = 0xEDB88320 ^ (c >>> 1);
        } else {
          c = c >>> 1;
        }
      }
      table[i] = c;
    }
    return table;
  }();

  static int _crc32(Uint8List data) {
    var c = 0xFFFFFFFF;
    for (var i = 0; i < data.length; i++) {
      c = _crcTable[(c ^ data[i]) & 0xFF] ^ (c >>> 8);
    }
    return (c ^ 0xFFFFFFFF) & 0xFFFFFFFF;
  }
}
