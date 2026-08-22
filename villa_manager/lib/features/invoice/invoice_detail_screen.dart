import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/currency_input_formatter.dart';
import '../../core/utils/formatters.dart';
import '../../data/repositories/invoice_repository.dart';
import '../../services/pdf_service.dart';
import '../../services/share_service.dart';
import '../dashboard/dashboard_providers.dart';
import '../settings/settings_providers.dart';
import 'invoice_providers.dart';

class InvoiceDetailScreen extends ConsumerStatefulWidget {
  const InvoiceDetailScreen({super.key, required this.invoiceId});
  final String invoiceId;

  @override
  ConsumerState<InvoiceDetailScreen> createState() =>
      _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends ConsumerState<InvoiceDetailScreen> {
  bool _busy = false;
  String get invoiceId => widget.invoiceId;

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await action();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Operasi gagal: $error')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _refresh() {
    ref.invalidate(invoiceDetailProvider(invoiceId));
    ref.invalidate(invoiceListProvider);
    ref.invalidate(overdueUnpaidCountProvider);
    ref.invalidate(dashboardProvider);
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(invoiceDetailProvider(invoiceId));
    final settings = ref.watch(appSettingsProvider).valueOrNull;

    return async.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
      data: (detail) {
        if (detail == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Invoice tidak ditemukan')),
          );
        }
        final inv = detail.invoice;
        final status = detail.effectiveStatus;

        final (statusBg, statusFg, statusLabel) = switch (status) {
          'paid' => (AppColors.availableBg, AppColors.availableGreen, 'LUNAS'),
          'partial' => (
            AppColors.goldBg,
            const Color(0xFF8D6E63),
            'DP DITERIMA',
          ),
          _ => (AppColors.occupiedBg, AppColors.occupiedRed, 'BELUM LUNAS'),
        };

        return Scaffold(
          appBar: AppBar(
            title: Text(inv.invoiceNumber),
            actions: [
              IconButton(
                tooltip: 'Export PDF Guest Folio',
                icon: const Icon(Icons.picture_as_pdf_outlined),
                onPressed: _busy
                    ? null
                    : () => _run(() async {
                        if (settings == null ||
                            settings.bankAccounts.trim().isEmpty) {
                          throw StateError(
                            'Lengkapi rekening pembayaran di Pengaturan',
                          );
                        }
                        await PdfService().exportInvoice(detail, settings);
                      }),
              ),
              IconButton(
                tooltip: 'Bagikan invoice',
                icon: const Icon(Icons.send_outlined),
                onPressed: _busy
                    ? null
                    : () => _run(() async {
                        if (settings == null ||
                            settings.bankAccounts.trim().isEmpty) {
                          throw StateError(
                            'Lengkapi rekening pembayaran di Pengaturan',
                          );
                        }
                        await ShareService().shareInvoice(detail, settings);
                      }),
              ),
              IconButton(
                tooltip: 'Hapus Invoice',
                icon: const Icon(Icons.delete_outline),
                onPressed: _busy
                    ? null
                    : () async {
                        final ok = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Hapus invoice?'),
                            content: Text(
                              'Invoice ${inv.invoiceNumber} akan dihapus permanen.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: const Text('Batal'),
                              ),
                              FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text('Hapus'),
                              ),
                            ],
                          ),
                        );
                        if (ok == true && context.mounted) {
                          await _run(() async {
                            await ref
                                .read(invoiceRepoProvider)
                                .delete(invoiceId);
                            if (mounted) context.go('/invoices');
                          });
                        }
                      },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Guest & Status Header Card
              Card(
                elevation: 0,
                color: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.border),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              inv.guestName,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusBg,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: statusFg.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              statusLabel,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: statusFg,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Villa: ${inv.villaName}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Jadwal: ${formatDate(inv.checkIn)} s.d. ${formatDate(inv.checkOut)}',
                      ),
                      Text(
                        'Terbit: ${formatDate(inv.dateIssued)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const Divider(height: 24),

                      // Quick Payment Status Controls
                      Row(
                        children: [
                          if (status != 'paid') ...[
                            Expanded(
                              child: FilledButton.icon(
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.availableGreen,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                ),
                                onPressed: _busy || detail.remainingBalance <= 0
                                    ? null
                                    : () => _run(() async {
                                        await ref
                                            .read(invoiceRepoProvider)
                                            .addPayment(
                                              invoiceId: invoiceId,
                                              amount: detail.remainingBalance,
                                              paymentMethod: 'Transfer Bank',
                                              notes: 'Pelunasan Cepat',
                                            );
                                        _refresh();
                                        if (mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Invoice berhasil ditandai LUNAS!',
                                              ),
                                              backgroundColor:
                                                  AppColors.availableGreen,
                                            ),
                                          );
                                        }
                                      }),
                                icon: const Icon(
                                  Icons.check_circle_outline,
                                  size: 16,
                                ),
                                label: const Text(
                                  'Tandai Langsung Lunas',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ] else ...[
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.occupiedRed,
                                  side: const BorderSide(
                                    color: AppColors.occupiedRed,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                ),
                                onPressed: _busy
                                    ? null
                                    : () async {
                                        final confirmed = await showDialog<bool>(
                                          context: context,
                                          builder: (dialogContext) => AlertDialog(
                                            title: const Text(
                                              'Hapus seluruh pembayaran?',
                                            ),
                                            content: const Text(
                                              'Riwayat pembayaran invoice ini akan dihapus permanen.',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                  dialogContext,
                                                  false,
                                                ),
                                                child: const Text('Batal'),
                                              ),
                                              FilledButton(
                                                onPressed: () => Navigator.pop(
                                                  dialogContext,
                                                  true,
                                                ),
                                                child: const Text('Hapus'),
                                              ),
                                            ],
                                          ),
                                        );
                                        if (confirmed != true || !mounted) {
                                          return;
                                        }
                                        await _run(() async {
                                          await ref
                                              .read(invoiceRepoProvider)
                                              .clearPayments(invoiceId);
                                          _refresh();
                                        });
                                      },
                                icon: const Icon(Icons.replay, size: 16),
                                label: const Text(
                                  'Reset ke Belum Lunas',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Rincian Biaya (Items)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rincian Tagihan',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton.icon(
                    onPressed: _busy ? null : () => _addItem(context, ref),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Tambah Item'),
                  ),
                ],
              ),
              ...detail.items.map(
                (item) => Card(
                  margin: const EdgeInsets.only(bottom: 6),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: ListTile(
                    title: Text(item.description),
                    subtitle: Text(
                      '${item.qty} × ${formatCurrency(item.price)}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          formatCurrency(item.qty * item.price),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 4),
                        IconButton(
                          icon: const Icon(Icons.close, size: 16),
                          onPressed: _busy
                              ? null
                              : () async {
                                  final ok = await showDialog<bool>(
                                    context: context,
                                    builder: (dialogContext) => AlertDialog(
                                      title: const Text('Hapus item invoice?'),
                                      content: Text(item.description),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                            dialogContext,
                                            false,
                                          ),
                                          child: const Text('Batal'),
                                        ),
                                        FilledButton(
                                          onPressed: () => Navigator.pop(
                                            dialogContext,
                                            true,
                                          ),
                                          child: const Text('Hapus'),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (ok != true || !mounted) return;
                                  await _run(() async {
                                    await ref
                                        .read(invoiceRepoProvider)
                                        .deleteItem(invoiceId, item.id);
                                    _refresh();
                                  });
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Riwayat Pembayaran (DP & Pelunasan)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pembayaran Diterima (DP / Cicilan)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton.tonalIcon(
                      style: FilledButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                      ),
                      onPressed: _busy
                          ? null
                          : () => _addPayment(context, ref, detail),
                      icon: const Icon(Icons.add_card, size: 16),
                      label: const Text('+ Catat DP'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              if (detail.payments.isEmpty)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.gold, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Belum ada pembayaran atau DP tercatat. Tap "+ Catat DP" untuk memasukkan cicilan atau tap "Tandai Langsung Lunas" di atas.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...detail.payments.map(
                  (p) => Card(
                    margin: const EdgeInsets.only(bottom: 6),
                    elevation: 0,
                    color: AppColors.availableBg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: AppColors.border),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.check_circle,
                        color: AppColors.availableGreen,
                      ),
                      title: Text(
                        formatCurrency(p.amount),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.availableGreen,
                        ),
                      ),
                      subtitle: Text(
                        '${formatDate(p.datePaid)} · ${p.paymentMethod}${p.notes.isNotEmpty ? ' (${p.notes})' : ''}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: Colors.red,
                        ),
                        onPressed: _busy
                            ? null
                            : () async {
                                final ok = await showDialog<bool>(
                                  context: context,
                                  builder: (dialogContext) => AlertDialog(
                                    title: const Text('Hapus pembayaran?'),
                                    content: Text(formatCurrency(p.amount)),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(dialogContext, false),
                                        child: const Text('Batal'),
                                      ),
                                      FilledButton(
                                        onPressed: () =>
                                            Navigator.pop(dialogContext, true),
                                        child: const Text('Hapus'),
                                      ),
                                    ],
                                  ),
                                );
                                if (ok != true || !mounted) return;
                                await _run(() async {
                                  await ref
                                      .read(invoiceRepoProvider)
                                      .deletePayment(invoiceId, p.id);
                                  _refresh();
                                });
                              },
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // Financial Summary Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textPrimary.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Tagihan:',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          formatCurrency(detail.total),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Telah Dibayar (DP):',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.availableGreen,
                          ),
                        ),
                        Text(
                          formatCurrency(detail.paidAmount),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.availableGreen,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SISA TAGIHAN:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: detail.remainingBalance > 0
                                ? AppColors.occupiedRed
                                : AppColors.availableGreen,
                          ),
                        ),
                        Text(
                          formatCurrency(detail.remainingBalance),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: detail.remainingBalance > 0
                                ? AppColors.occupiedRed
                                : AppColors.availableGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _addItem(BuildContext context, WidgetRef ref) async {
    final desc = TextEditingController();
    final qty = TextEditingController(text: '1');
    final price = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tambah Item Tagihan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: desc,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                hintText: 'Mis: Extra Bed, Floating Breakfast',
              ),
            ),
            TextField(
              controller: qty,
              decoration: const InputDecoration(labelText: 'Qty'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TextField(
              controller: price,
              decoration: const InputDecoration(
                labelText: 'Harga satuan',
                prefixText: 'Rp ',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [CurrencyInputFormatter()],
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
    if (ok == true && desc.text.trim().isNotEmpty) {
      await ref
          .read(invoiceRepoProvider)
          .addItem(
            invoiceId: invoiceId,
            description: desc.text.trim(),
            qty: int.tryParse(qty.text) ?? 1,
            price: parseCurrency(price.text),
          );
      ref.invalidate(invoiceDetailProvider(invoiceId));
    }
    desc.dispose();
    qty.dispose();
    price.dispose();
  }

  Future<void> _addPayment(
    BuildContext context,
    WidgetRef ref,
    InvoiceDetail detail,
  ) async {
    final defaultAmount = detail.remainingBalance > 0
        ? (detail.paidAmount == 0
              ? (detail.total / 2).round()
              : detail.remainingBalance)
        : detail.total;

    final amountCtrl = TextEditingController(
      text: formatCurrencyInput(defaultAmount),
    );
    final notesCtrl = TextEditingController(
      text: detail.paidAmount == 0 ? 'DP 50%' : 'Pelunasan',
    );
    String method = 'Transfer Bank';

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Catat Pembayaran / DP'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nominal Dibayar',
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [CurrencyInputFormatter()],
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: method,
                decoration: const InputDecoration(
                  labelText: 'Metode Pembayaran',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Transfer Bank',
                    child: Text('Transfer Bank'),
                  ),
                  DropdownMenuItem(value: 'Cash', child: Text('Cash / Tunai')),
                  DropdownMenuItem(value: 'QRIS', child: Text('QRIS')),
                  DropdownMenuItem(
                    value: 'Kartu Kredit',
                    child: Text('Kartu Kredit'),
                  ),
                ],
                onChanged: (v) => setDialogState(() => method = v ?? method),
              ),
              TextField(
                controller: notesCtrl,
                decoration: const InputDecoration(
                  labelText: 'Keterangan (opsional)',
                  hintText: 'Mis: DP 50%, Pelunasan',
                ),
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
              child: const Text('Simpan Pembayaran'),
            ),
          ],
        ),
      ),
    );

    if (ok == true) {
      final amt = parseCurrency(amountCtrl.text);
      if (amt > 0) {
        await ref
            .read(invoiceRepoProvider)
            .addPayment(
              invoiceId: invoiceId,
              amount: amt,
              paymentMethod: method,
              notes: notesCtrl.text.trim(),
            );
        ref.invalidate(invoiceDetailProvider(invoiceId));
      }
    }

    amountCtrl.dispose();
    notesCtrl.dispose();
  }
}
