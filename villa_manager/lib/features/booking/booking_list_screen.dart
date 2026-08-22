import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/booking_utils.dart';
import '../../core/utils/formatters.dart';
import '../../core/utils/message_templates.dart';
import '../../data/repositories/booking_repository.dart';
import '../../services/share_service.dart';
import '../invoice/invoice_providers.dart';
import '../settings/settings_providers.dart';
import '../villa/villa_providers.dart';
import 'booking_providers.dart';

class BookingListScreen extends ConsumerWidget {
  const BookingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(bookingFilterProvider);
    final bookings = ref.watch(filteredBookingsProvider);
    final invoiceIds = ref.watch(bookingInvoiceIdsProvider).valueOrNull ?? {};

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Booking')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: BookingFilter.values.map((f) {
                final label = switch (f) {
                  BookingFilter.all => 'Semua',
                  BookingFilter.upcoming => 'Akan datang',
                  BookingFilter.ongoing => 'Berlangsung',
                  BookingFilter.done => 'Selesai',
                  BookingFilter.cancelled => 'Batal',
                };
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: FilterChip(
                    label: Text(label),
                    selected: filter == f,
                    onSelected: (_) =>
                        ref.read(bookingFilterProvider.notifier).state = f,
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: bookings.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (list) {
                if (list.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            size: 56, color: Colors.grey),
                        SizedBox(height: 12),
                        Text('Belum ada data booking'),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final row = list[i];
                    final b = row.booking;
                    final hasInvoice = invoiceIds.contains(b.id);
                    return _BookingCard(
                      row: row,
                      hasInvoice: hasInvoice,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/bookings/new'),
        icon: const Icon(Icons.add),
        label: const Text('Booking Baru'),
      ),
    );
  }
}

class _BookingCard extends ConsumerWidget {
  const _BookingCard({
    required this.row,
    required this.hasInvoice,
  });
  final BookingWithVilla row;
  final bool hasInvoice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = row.booking;
    final phase = bookingPhase(b.checkIn, b.checkOut, b.status);
    final nights = nightsBetween(b.checkIn, b.checkOut);
    final thumb = ref.watch(villaThumbProvider(b.villaId));

    final (badgeBg, badgeFg) = switch (phase) {
      BookingPhase.upcoming => (Colors.blue.shade50, Colors.blue.shade800),
      BookingPhase.ongoing => (Colors.green.shade50, Colors.green.shade800),
      BookingPhase.done => (Colors.grey.shade200, Colors.grey.shade700),
      BookingPhase.cancelled => (Colors.red.shade50, Colors.red.shade800),
    };

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/bookings/${b.id}/edit'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Villa thumbnail
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 54,
                      height: 54,
                      child: thumb.when(
                        loading: () => const ColoredBox(color: Colors.black12),
                        error: (_, __) => const ColoredBox(
                            color: Colors.black12,
                            child: Icon(Icons.home, size: 24)),
                        data: (ph) => ph == null
                            ? const ColoredBox(
                                color: Colors.black12,
                                child: Icon(Icons.home, size: 24))
                            : Image.file(
                                File(ph.filePath),
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const ColoredBox(color: Colors.black12),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                row.villaName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: badgeBg,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                bookingPhaseLabel(phase),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: badgeFg,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.person,
                                size: 14, color: Colors.grey.shade600),
                            const SizedBox(width: 4),
                            Text(
                              b.guestName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            if (b.guestContact.isNotEmpty) ...[
                              Text(' · ',
                                  style: TextStyle(
                                      color: Colors.grey.shade500)),
                              Text(
                                b.guestContact,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey.shade600),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.date_range,
                              size: 14, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text(
                            '${formatDate(b.checkIn)} → ${formatDate(b.checkOut)} ($nights mlm)',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        formatCurrency(row.total),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ],
                  ),
                  if (b.status != 'cancelled')
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Kirim Info Tamu ke Penjaga (WA)',
                          icon: const Icon(Icons.key, size: 18),
                          onPressed: () async {
                            final villa = await ref
                                .read(villaRepoProvider)
                                .getById(b.villaId);
                            if (villa == null) return;
                            final settings =
                                ref.read(appSettingsProvider).valueOrNull;
                            final msg = butlerNotificationText(
                              villa: villa,
                              booking: b,
                              settings: settings,
                            );
                            await ShareService().shareTextOnly(msg);
                          },
                        ),
                        const SizedBox(width: 4),
                        hasInvoice
                            ? OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  visualDensity: VisualDensity.compact,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                ),
                                icon: const Icon(Icons.check, size: 15),
                                label: const Text('Invoice Ada'),
                                onPressed: () async {
                                  final inv = await ref
                                      .read(invoiceRepoProvider)
                                      .byBookingId(b.id);
                                  if (inv != null && context.mounted) {
                                    context.push('/invoices/${inv.id}');
                                  }
                                },
                              )
                            : FilledButton.tonalIcon(
                                style: FilledButton.styleFrom(
                                  visualDensity: VisualDensity.compact,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                ),
                                icon: const Icon(Icons.receipt_long, size: 15),
                                label: const Text('Buat Invoice'),
                                onPressed: () async {
                                  final id = await ref
                                      .read(invoiceRepoProvider)
                                      .createFromBooking(
                                        booking: b,
                                        villaName: row.villaName,
                                      );
                                  if (context.mounted) {
                                    context.push('/invoices/$id');
                                  }
                                },
                              ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
