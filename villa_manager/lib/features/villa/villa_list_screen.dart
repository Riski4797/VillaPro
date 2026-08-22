import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/currency_input_formatter.dart';
import '../../core/utils/formatters.dart';
import '../../data/database/app_database.dart';
import '../../services/brochure_service.dart';
import '../settings/settings_providers.dart';
import 'share_to_customer_sheet.dart';
import 'villa_providers.dart';

class VillaListScreen extends ConsumerWidget {
  const VillaListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeOnly = ref.watch(villaActiveOnlyProvider);
    final matcherFilter = ref.watch(smartMatcherFilterProvider);
    final settings = ref.watch(appSettingsProvider).valueOrNull;

    // Use smart matcher results if matcher active, otherwise standard search stream
    final AsyncValue<List<Villa>> villasAsync = matcherFilter.isActive
        ? ref.watch(smartMatchedVillasProvider)
        : ref.watch(villaListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Villa'),
        actions: [
          IconButton(
            tooltip: 'Smart Matcher (Cari Cepat)',
            icon: Icon(
              matcherFilter.isActive
                  ? Icons.filter_alt
                  : Icons.filter_alt_outlined,
              color:
                  matcherFilter.isActive ? AppColors.gold : AppColors.primary,
            ),
            onPressed: () => _showSmartMatcherDialog(context, ref),
          ),
          IconButton(
            tooltip: 'Cetak Katalog PDF',
            icon: const Icon(Icons.picture_as_pdf_outlined),
            onPressed: () async {
              final list = villasAsync.valueOrNull ?? [];
              if (list.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tidak ada villa untuk dicetak')),
                );
                return;
              }
              final photoMap = <String, String?>{};
              final repo = ref.read(villaRepoProvider);
              for (final v in list) {
                final firstPh = await repo.firstPhoto(v.id);
                photoMap[v.id] = firstPh?.filePath;
              }
              BrochureService().exportMultiVillaCatalog(
                villas: list,
                photoPaths: photoMap,
                settings: settings,
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          // Smart Matcher Active Filter Indicator (if any)
          if (matcherFilter.isActive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppColors.goldBg,
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome,
                      size: 18, color: Color(0xFF8D6E63)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Smart Matcher: ${matcherFilter.checkIn != null ? "${formatDate(matcherFilter.checkIn!)} - ${formatDate(matcherFilter.checkOut!)}" : ""}'
                      '${matcherFilter.maxPrice != null ? " · Max ${formatCurrency(matcherFilter.maxPrice!)}" : ""}'
                      '${matcherFilter.locationQuery != null && matcherFilter.locationQuery!.isNotEmpty ? " · ${matcherFilter.locationQuery}" : ""}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8D6E63),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 16),
                    onPressed: () => ref
                        .read(smartMatcherFilterProvider.notifier)
                        .state = const SmartMatcherFilter(),
                  ),
                ],
              ),
            ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari nama villa atau lokasi…',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      isDense: true,
                    ),
                    onChanged: (v) =>
                        ref.read(villaSearchProvider.notifier).state = v,
                  ),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(activeOnly ? 'Aktif' : 'Semua'),
                  selected: activeOnly,
                  onSelected: (v) =>
                      ref.read(villaActiveOnlyProvider.notifier).state = v,
                ),
              ],
            ),
          ),
          Expanded(
            child: villasAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (list) {
                if (list.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.holiday_village_outlined,
                            size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text(
                          matcherFilter.isActive
                              ? 'Tidak ada villa yang cocok dengan kriteria'
                              : 'Belum ada data villa',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          matcherFilter.isActive
                              ? 'Coba longgarkan budget atau tanggal booking'
                              : 'Tap tombol di bawah untuk menambah villa pertama',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (_, i) => _VillaLandscapeCard(villa: list[i]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () => context.push('/villas/new'),
        icon: const Icon(Icons.add),
        label: const Text('Tambah Villa'),
      ),
    );
  }

  Future<void> _showSmartMatcherDialog(
      BuildContext context, WidgetRef ref) async {
    final current = ref.read(smartMatcherFilterProvider);
    DateTime? checkIn = current.checkIn;
    DateTime? checkOut = current.checkOut;
    final budgetCtrl = TextEditingController(
      text: current.maxPrice != null
          ? formatCurrencyInput(current.maxPrice!)
          : '',
    );
    final locCtrl =
        TextEditingController(text: current.locationQuery ?? '');

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '🔍 Smart Villa Matcher',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const Text(
                'Temukan villa yang PASTI KOSONG & masuk budget tamu.',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),

              // Date Range Picker
              const Text('1. Tanggal Menginap Tamu:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final now = DateTime.now();
                        final range = await showDateRangePicker(
                          context: ctx,
                          firstDate: now,
                          lastDate: now.add(const Duration(days: 365)),
                          initialDateRange: (checkIn != null && checkOut != null)
                              ? DateTimeRange(start: checkIn!, end: checkOut!)
                              : null,
                        );
                        if (range != null) {
                          setSheetState(() {
                            checkIn = range.start;
                            checkOut = range.end;
                          });
                        }
                      },
                      icon: const Icon(Icons.date_range, size: 16),
                      label: Text(
                        (checkIn != null && checkOut != null)
                            ? '${formatDate(checkIn!)} → ${formatDate(checkOut!)}'
                            : 'Pilih Tanggal Check-in & Out',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Budget Max
              const Text('2. Budget Maksimal / Malam:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 6),
              TextField(
                controller: budgetCtrl,
                decoration: const InputDecoration(
                  labelText: 'Maksimal Harga / Malam',
                  hintText: 'Mis: 2.000.000',
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [CurrencyInputFormatter()],
              ),

              const SizedBox(height: 14),

              // Location
              const Text('3. Area / Lokasi:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 6),
              TextField(
                controller: locCtrl,
                decoration: const InputDecoration(
                  labelText: 'Area / Kota (opsional)',
                  hintText: 'Mis: Ubud, Canggu, Seminyak',
                  prefixIcon: Icon(Icons.location_on_outlined, size: 20),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  if (current.isActive)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          ref
                              .read(smartMatcherFilterProvider.notifier)
                              .state = const SmartMatcherFilter();
                          Navigator.pop(ctx);
                        },
                        child: const Text('Reset Filter'),
                      ),
                    ),
                  if (current.isActive) const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        final maxP = parseCurrency(budgetCtrl.text);
                        ref.read(smartMatcherFilterProvider.notifier).state =
                            SmartMatcherFilter(
                          checkIn: checkIn,
                          checkOut: checkOut,
                          maxPrice: maxP > 0 ? maxP : null,
                          locationQuery: locCtrl.text.trim().isNotEmpty
                              ? locCtrl.text.trim()
                              : null,
                        );
                        ref.invalidate(smartMatchedVillasProvider);
                        Navigator.pop(ctx);
                      },
                      icon: const Icon(Icons.search),
                      label: const Text('Cari Villa Kosong'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    budgetCtrl.dispose();
    locCtrl.dispose();
  }
}

class _VillaLandscapeCard extends ConsumerWidget {
  const _VillaLandscapeCard({required this.villa});
  final Villa villa;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumb = ref.watch(villaThumbProvider(villa.id));
    final occupancyAsync = ref.watch(villaOccupancyProvider(villa.id));
    final commission = VillaCommission(
      type: villa.commissionType,
      percent: villa.commissionPercent,
      fixed: villa.commissionFixed,
    );

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/villas/${villa.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Landscape Cover Image (16:9 or fixed height 150)
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: thumb.when(
                    loading: () => Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    error: (_, __) => _coverPlaceholder(),
                    data: (ph) => ph == null
                        ? _coverPlaceholder()
                        : Image.file(
                            File(ph.filePath),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _coverPlaceholder(),
                          ),
                  ),
                ),

                // Floating Availability / Nonaktif Badge (Top Left)
                Positioned(
                  top: 10,
                  left: 10,
                  child: !villa.isActive
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Nonaktif',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : occupancyAsync.when(
                          loading: () => const SizedBox.shrink(),
                          error: (_, __) => const SizedBox.shrink(),
                          data: (occ) {
                            if (occ.isOccupiedToday) {
                              final cout = occ.currentBooking!.checkOut;
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade700,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Terisi s.d ${formatDate(cout)}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF4ADE80),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    'Tersedia Hari Ini',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),

                // Floating Share Button (Top Right)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Material(
                    color: Colors.white.withValues(alpha: 0.9),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () =>
                          showShareToCustomerSheet(context, villa: villa),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.share,
                            size: 18, color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Card Body Information
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          villa.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.goldBg,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: AppColors.gold.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          'Komisi: ${commission.label}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8D6E63),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (villa.location.isNotEmpty)
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            villa.location,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  const Divider(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: formatCurrency(villa.priceWeekday),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            TextSpan(
                              text: ' / malam',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Row(
                        children: [
                          Text(
                            'Detail',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          Icon(Icons.chevron_right,
                              size: 16, color: AppColors.primary),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _coverPlaceholder() {
    return Container(
      color: Colors.grey.shade100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.villa_outlined, size: 36, color: Colors.grey.shade400),
            const SizedBox(height: 4),
            Text(
              'Belum ada foto villa',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}
