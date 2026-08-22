import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/message_templates.dart';
import '../../data/database/app_database.dart';
import '../../services/brochure_service.dart';
import '../../services/share_service.dart';
import '../settings/settings_providers.dart';
import 'villa_providers.dart';

Future<void> showShareToCustomerSheet(
  BuildContext context, {
  required Villa villa,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _ShareSheet(villa: villa),
  );
}

class _ShareSheet extends ConsumerStatefulWidget {
  const _ShareSheet({required this.villa});
  final Villa villa;

  @override
  ConsumerState<_ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends ConsumerState<_ShareSheet> {
  ShareTemplate _template = ShareTemplate.teaser;
  final _selectedPhotos = <String>{};
  final _textCtrl = TextEditingController();
  bool _inited = false;
  bool _sharing = false;

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  void _syncTemplateText(AppSetting? settings) {
    _textCtrl.text = villaShareText(widget.villa, _template, settings);
  }

  @override
  Widget build(BuildContext context) {
    final photosAsync = ref.watch(villaPhotosProvider(widget.villa.id));
    final settings = ref.watch(appSettingsProvider).valueOrNull;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollCtrl) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: photosAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('$e')),
            data: (photos) {
              if (!_inited) {
                if (photos.isNotEmpty) {
                  _selectedPhotos.add(photos.first.id);
                }
                _syncTemplateText(settings);
                _inited = true;
              }

              return ListView(
                controller: scrollCtrl,
                padding: const EdgeInsets.all(18),
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bagikan Info Villa',
                          style: Theme.of(context).textTheme.titleLarge),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          BrochureService().exportSingleVillaBrochure(
                            villa: widget.villa,
                            photos: photos,
                            settings: settings,
                          );
                        },
                        icon: const Icon(Icons.picture_as_pdf, size: 16),
                        label: const Text('Brosur PDF'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Template selector chips
                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('Teaser Singkat'),
                        selected: _template == ShareTemplate.teaser,
                        onSelected: (_) {
                          setState(() {
                            _template = ShareTemplate.teaser;
                            _syncTemplateText(settings);
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Detail Lengkap'),
                        selected: _template == ShareTemplate.detail,
                        onSelected: (_) {
                          setState(() {
                            _template = ShareTemplate.detail;
                            _syncTemplateText(settings);
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Price List'),
                        selected: _template == ShareTemplate.priceList,
                        onSelected: (_) {
                          setState(() {
                            _template = ShareTemplate.priceList;
                            _syncTemplateText(settings);
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Editable Message Preview Box
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pesan WhatsApp (Bisa Diedit):',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                            visualDensity: VisualDensity.compact),
                        onPressed: () =>
                            setState(() => _syncTemplateText(settings)),
                        icon: const Icon(Icons.refresh, size: 14),
                        label: const Text('Reset Template',
                            style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _textCtrl,
                    maxLines: 7,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),

                  const SizedBox(height: 16),

                  // Photo selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pilih Foto untuk Dikirim:',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${_selectedPhotos.length} dipilih',
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (photos.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Belum ada foto villa — hanya pesan teks yang akan dibagikan.',
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  else
                    SizedBox(
                      height: 90,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: photos.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (_, i) {
                          final ph = photos[i];
                          final sel = _selectedPhotos.contains(ph.id);
                          return GestureDetector(
                            onTap: () => setState(() {
                              if (sel) {
                                _selectedPhotos.remove(ph.id);
                              } else {
                                _selectedPhotos.add(ph.id);
                              }
                            }),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(ph.filePath),
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 90,
                                      height: 90,
                                      color: Colors.grey.shade300,
                                      child: const Icon(Icons.broken_image),
                                    ),
                                  ),
                                ),
                                if (sel)
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: CircleAvatar(
                                      radius: 11,
                                      backgroundColor: AppColors.availableGreen,
                                      child: const Icon(Icons.check,
                                          size: 14, color: Colors.white),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Share Action Button
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: _sharing
                        ? null
                        : () async {
                            setState(() => _sharing = true);
                            try {
                              final chosen = photos
                                  .where(
                                      (p) => _selectedPhotos.contains(p.id))
                                  .toList();
                              final textToSend = _textCtrl.text.trim();
                              await ShareService().shareVilla(
                                villa: widget.villa,
                                template: _template,
                                photos: chosen,
                                customText: textToSend,
                                settings: settings,
                              );
                              if (context.mounted) Navigator.pop(context);
                            } finally {
                              if (mounted) setState(() => _sharing = false);
                            }
                          },
                    icon: const Icon(Icons.send),
                    label: Text(
                        _sharing ? 'Membuka WhatsApp…' : 'Kirim via WhatsApp'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
