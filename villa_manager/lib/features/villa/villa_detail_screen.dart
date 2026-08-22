import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/villa_repository.dart';
import '../../services/brochure_service.dart';
import '../settings/settings_providers.dart';
import 'share_to_customer_sheet.dart';
import 'villa_providers.dart';

class VillaDetailScreen extends ConsumerWidget {
  const VillaDetailScreen({super.key, required this.villaId});
  final String villaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(villaDetailProvider(villaId));

    return async.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
      data: (v) {
        if (v == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Villa tidak ditemukan')),
          );
        }
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text(v.name),
              actions: [
                IconButton(
                  tooltip: 'Cetak Brosur PDF',
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  onPressed: () async {
                    try {
                      final repo = ref.read(villaRepoProvider);
                      final photos = await repo.watchPhotos(villaId).first;
                      if (!context.mounted) return;
                      final settings = ref
                          .read(appSettingsProvider)
                          .valueOrNull;
                      await BrochureService().exportSingleVillaBrochure(
                        villa: v,
                        photos: photos,
                        settings: settings,
                      );
                    } catch (error) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Gagal membuat brosur: $error'),
                          ),
                        );
                      }
                    }
                  },
                ),
                IconButton(
                  tooltip: 'Edit Villa',
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () => context.push('/villas/$villaId/edit'),
                ),
                IconButton(
                  tooltip: 'Hapus Villa',
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _confirmDelete(context, ref, v),
                ),
              ],
              bottom: const TabBar(
                isScrollable: true,
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorWeight: 3,
                tabs: [
                  Tab(icon: Icon(Icons.info_outline, size: 18), text: 'Info'),
                  Tab(
                    icon: Icon(Icons.photo_library_outlined, size: 18),
                    text: 'Foto & Video',
                  ),
                  Tab(icon: Icon(Icons.help_outline, size: 18), text: 'FAQ'),
                  Tab(
                    icon: Icon(Icons.lock_outline, size: 18),
                    text: 'Catatan Owner',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _InfoTab(villa: v),
                _PhotosTab(villaId: villaId),
                _FaqsTab(villaId: villaId),
                _PrivateTab(villa: v),
              ],
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: SafeArea(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => showShareToCustomerSheet(context, villa: v),
                  icon: const Icon(Icons.share),
                  label: const Text('Bagikan ke Pelanggan'),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Villa v,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus villa?'),
        content: Text(
          '${v.name}, foto, dan FAQ akan dihapus. Villa dengan riwayat booking tidak dapat dihapus.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (ok == true) {
      try {
        await ref.read(villaRepoProvider).delete(villaId);
        if (context.mounted) context.go('/villas');
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Villa memiliki riwayat booking dan tidak dapat dihapus.',
              ),
            ),
          );
        }
      }
    }
  }
}

class _InfoTab extends ConsumerWidget {
  const _InfoTab({required this.villa});
  final Villa villa;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usps = VillaRepository.decodeList(villa.uniqueSellingPoints);
    final amenities = VillaRepository.decodeList(villa.amenities);
    final occupancyAsync = ref.watch(villaOccupancyProvider(villa.id));
    final thumb = ref.watch(villaThumbProvider(villa.id));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Cover Photo Banner (if available)
        thumb.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
          data: (ph) => ph == null
              ? const SizedBox.shrink()
              : Container(
                  height: 180,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: FileImage(File(ph.filePath)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),

        // Status Card
        if (!villa.isActive) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Row(
              children: [
                Icon(Icons.pause_circle_outline, color: Colors.grey),
                SizedBox(width: 10),
                Text(
                  'Status: Nonaktif (disembunyikan dari katalog)',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ] else ...[
          occupancyAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (occ) {
              if (occ.isOccupiedToday) {
                final b = occ.currentBooking!;
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.occupiedBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.hotel, color: AppColors.occupiedRed),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'SEDANG TERISI HARI INI',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.occupiedRed,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Tamu: ${b.guestName} · Check-out: ${formatDate(b.checkOut)}',
                              style: TextStyle(
                                color: Colors.red.shade900,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.availableBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: AppColors.availableGreen,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TERSEDIA HARI INI',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.availableGreen,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            occ.nextBooking == null
                                ? 'Belum ada jadwal booking'
                                : 'Booking terdekat: ${formatDate(occ.nextBooking!.checkIn)} (${occ.nextBooking!.guestName})',
                            style: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
        ],

        // Location Info
        if (villa.location.isNotEmpty)
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  villa.location,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),

        const SizedBox(height: 12),

        // Description
        if (villa.description.isNotEmpty) ...[
          Text(
            villa.description,
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 20),
        ],

        // Price Tier Box
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tarif Sewa Villa',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 12),
                _PriceRow(
                  label: 'Hari Kerja (Weekday)',
                  amount: villa.priceWeekday,
                ),
                const Divider(height: 16),
                _PriceRow(
                  label: 'Akhir Pekan (Weekend)',
                  amount: villa.priceWeekend,
                ),
                const Divider(height: 16),
                _PriceRow(
                  label: 'Musim Liburan (High Season)',
                  amount: villa.priceHighSeason,
                ),
              ],
            ),
          ),
        ),

        // Keunggulan (USPs)
        if (usps.isNotEmpty) ...[
          const SizedBox(height: 20),
          const Text(
            'Keunggulan / Selling Points',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          ...usps.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('✨ ', style: TextStyle(fontSize: 13)),
                  Expanded(
                    child: Text(e, style: const TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            ),
          ),
        ],

        // Fasilitas (Amenities)
        if (amenities.isNotEmpty) ...[
          const SizedBox(height: 20),
          const Text(
            'Fasilitas Lengkap',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: amenities
                .map(
                  (a) => Chip(
                    backgroundColor: AppColors.surface,
                    avatar: const Icon(
                      Icons.check,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    label: Text(a, style: const TextStyle(fontSize: 12)),
                  ),
                )
                .toList(),
          ),
        ],

        // Aturan Rumah
        if (villa.houseRules.isNotEmpty) ...[
          const SizedBox(height: 20),
          Card(
            color: Colors.amber.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.amber.shade200),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.rule, size: 18, color: Colors.amber.shade900),
                      const SizedBox(width: 8),
                      Text(
                        'Aturan Menginap (House Rules)',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    villa.houseRules,
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
        ],

        const SizedBox(height: 24),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.amount});
  final String label;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13)),
        Text(
          formatCurrency(amount),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _PhotosTab extends ConsumerWidget {
  const _PhotosTab({required this.villaId});
  final String villaId;

  Future<void> _addPhotos(WidgetRef ref) async {
    final files = await ImagePicker().pickMultiImage(imageQuality: 85);
    if (files.isEmpty) return;
    final repo = ref.read(villaRepoProvider);
    for (final f in files) {
      await repo.addPhoto(villaId, f.path);
    }
  }

  Future<void> _addVideo(BuildContext context, WidgetRef ref) async {
    final file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (file == null) return;
    await ref.read(villaRepoProvider).addVideo(villaId, file.path);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Video villa berhasil ditambahkan!'),
          backgroundColor: AppColors.availableGreen,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photos = ref.watch(villaPhotosProvider(villaId));
    return photos.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (list) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 8,
              children: [
                Text(
                  '${list.length} Media Tersimpan',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    FilledButton.tonalIcon(
                      style: FilledButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                      ),
                      onPressed: () => _addPhotos(ref),
                      icon: const Icon(Icons.add_photo_alternate, size: 16),
                      label: const Text('+ Foto'),
                    ),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                      ),
                      onPressed: () => _addVideo(context, ref),
                      icon: const Icon(Icons.video_library_outlined, size: 16),
                      label: const Text('+ Video'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: list.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.perm_media_outlined,
                          size: 48,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8),
                        Text('Belum ada foto atau video villa'),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: list.length,
                    itemBuilder: (_, i) {
                      final ph = list[i];
                      final isVideo = ph.mediaType == 'video';

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            if (isVideo)
                              Container(
                                color: const Color(0xFF1B2621),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.gold.withValues(
                                            alpha: 0.2,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.play_arrow,
                                          color: AppColors.gold,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'VIDEO TOUR',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else
                              Image.file(
                                File(ph.filePath),
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const ColoredBox(color: Colors.grey),
                              ),
                            if (isVideo)
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => showDialog<void>(
                                      context: context,
                                      builder: (_) => _VideoPreviewDialog(
                                        path: ph.filePath,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: Material(
                                color: Colors.black54,
                                shape: const CircleBorder(),
                                child: InkWell(
                                  customBorder: const CircleBorder(),
                                  onTap: () => ref
                                      .read(villaRepoProvider)
                                      .deletePhoto(ph),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (isVideo)
                              Positioned(
                                bottom: 4,
                                left: 4,
                                right: 4,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'MP4 Video',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _VideoPreviewDialog extends StatefulWidget {
  const _VideoPreviewDialog({required this.path});

  final String path;

  @override
  State<_VideoPreviewDialog> createState() => _VideoPreviewDialogState();
}

class _VideoPreviewDialogState extends State<_VideoPreviewDialog> {
  late final VideoPlayerController _controller;
  late final Future<void> _initialized;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path));
    _initialized = _controller.initialize().then((_) {
      _controller.setLooping(true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Video Tour'),
      content: SizedBox(
        width: 640,
        child: FutureBuilder<void>(
          future: _initialized,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text(
                'Preview video tersedia pada aplikasi Android.',
              );
            }
            if (snapshot.connectionState != ConnectionState.done) {
              return const SizedBox(
                height: 180,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return ValueListenableBuilder<VideoPlayerValue>(
              valueListenable: _controller,
              builder: (context, value, _) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => value.isPlaying
                        ? _controller.pause()
                        : _controller.play(),
                    child: AspectRatio(
                      aspectRatio: value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          VideoPlayer(_controller),
                          if (!value.isPlaying)
                            const Icon(
                              Icons.play_circle_fill,
                              size: 64,
                              color: Colors.white70,
                            ),
                        ],
                      ),
                    ),
                  ),
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    padding: const EdgeInsets.only(top: 10),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Tutup'),
        ),
      ],
    );
  }
}

class _FaqsTab extends ConsumerWidget {
  const _FaqsTab({required this.villaId});
  final String villaId;

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref, [
    VillaFaq? faq,
  ]) async {
    final qCtrl = TextEditingController(text: faq?.question ?? '');
    final aCtrl = TextEditingController(text: faq?.answer ?? '');
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(faq == null ? 'Tambah FAQ' : 'Edit FAQ'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: qCtrl,
              decoration: const InputDecoration(labelText: 'Pertanyaan'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: aCtrl,
              decoration: const InputDecoration(labelText: 'Jawaban'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    if (ok == true && qCtrl.text.trim().isNotEmpty) {
      await ref
          .read(villaRepoProvider)
          .upsertFaq(
            id: faq?.id,
            villaId: villaId,
            question: qCtrl.text.trim(),
            answer: aCtrl.text.trim(),
          );
    }
    qCtrl.dispose();
    aCtrl.dispose();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faqs = ref.watch(villaFaqsProvider(villaId));
    return faqs.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (list) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${list.length} FAQ Tersedia',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _edit(context, ref),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Tambah FAQ'),
                ),
              ],
            ),
          ),
          Expanded(
            child: list.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.question_answer_outlined,
                          size: 48,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8),
                        Text('Belum ada tanya jawab'),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final f = list[i];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Q: ${f.question}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit, size: 16),
                                    onPressed: () => _edit(context, ref, f),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      size: 16,
                                    ),
                                    onPressed: () => ref
                                        .read(villaRepoProvider)
                                        .deleteFaq(f.id),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'A: ${f.answer}',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _PrivateTab extends StatelessWidget {
  const _PrivateTab({required this.villa});
  final Villa villa;

  @override
  Widget build(BuildContext context) {
    final commission = VillaCommission(
      type: villa.commissionType,
      percent: villa.commissionPercent,
      fixed: villa.commissionFixed,
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.goldBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
          ),
          child: const Row(
            children: [
              Icon(Icons.lock, color: Color(0xFF8D6E63), size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Catatan Rahasia Marketer\n(Tidak akan pernah ikut terkirim ke customer)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8D6E63),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Owner Information Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.account_balance_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Pemilik Villa (Owner) & Setoran',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Nama Owner'),
                  subtitle: Text(
                    villa.ownerName.isEmpty ? '—' : villa.ownerName,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.phone_outlined),
                  title: const Text('Kontak / WhatsApp Owner'),
                  subtitle: Text(
                    villa.ownerContact.isEmpty ? '—' : villa.ownerContact,
                  ),
                ),
                if (villa.ownerBank.isNotEmpty) ...[
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.credit_card_outlined),
                    title: const Text('Rekening Setoran Owner'),
                    subtitle: Text(
                      villa.ownerBank,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Butler / Penjaga Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.key_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Penjaga Villa / Butler (Di Lokasi)',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (villa.isButlerSameAsOwner) ...[
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Penjaga & urusan kunci dipegang langsung oleh Owner.',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.badge_outlined),
                    title: const Text('Nama Penjaga'),
                    subtitle: Text(
                      villa.butlerName.isEmpty ? '—' : villa.butlerName,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.phone_android_outlined),
                    title: const Text('Kontak / WhatsApp Penjaga'),
                    subtitle: Text(
                      villa.butlerContact.isEmpty ? '—' : villa.butlerContact,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Commission Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.monetization_on_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Kesepakatan Komisi Marketer',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    commission.label,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  subtitle: Text(
                    villa.commissionType == 'fixed'
                        ? 'Komisi nominal tetap per transaksi booking'
                        : 'Komisi ${villa.commissionPercent}% dari total omzet sewa',
                  ),
                ),
                if (villa.privateNotes.isNotEmpty) ...[
                  const Divider(height: 16),
                  const Text(
                    'Catatan Tambahan:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    villa.privateNotes,
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
