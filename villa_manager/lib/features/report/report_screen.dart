import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/repositories/report_repository.dart';
import '../dashboard/dashboard_providers.dart';

enum _Period { thisMonth, pickMonth, custom }

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  _Period _period = _Period.thisMonth;
  late DateTime _from;
  late DateTime _to;
  ReportSummary? _summary;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _applyThisMonth();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  void _applyThisMonth() {
    final now = DateTime.now();
    _from = DateTime(now.year, now.month, 1);
    _to = DateTime(now.year, now.month + 1, 0);
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final s = await ref.read(reportRepoProvider).summary(_from, _to);
      if (mounted) setState(() => _summary = s);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _pickMonth() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _from,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 1, 12, 31),
      helpText: 'Pilih bulan laporan',
    );
    if (picked == null) return;
    setState(() {
      _period = _Period.pickMonth;
      _from = DateTime(picked.year, picked.month, 1);
      _to = DateTime(picked.year, picked.month + 1, 0);
    });
    await _load();
  }

  Future<void> _pickCustom() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(start: _from, end: _to),
    );
    if (range == null) return;
    setState(() {
      _period = _Period.custom;
      _from = range.start;
      _to = range.end;
    });
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final monthLabel = DateFormat('MMMM yyyy', 'id_ID').format(_from);

    return Scaffold(
      appBar: AppBar(title: const Text('Laporan Pendapatan & Komisi')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Period Selector Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ChoiceChip(
                  label: const Text('Bulan Ini'),
                  selected: _period == _Period.thisMonth,
                  onSelected: (_) async {
                    setState(() {
                      _period = _Period.thisMonth;
                      _applyThisMonth();
                    });
                    await _load();
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: Text(
                      _period == _Period.pickMonth ? monthLabel : 'Pilih Bulan'),
                  selected: _period == _Period.pickMonth,
                  onSelected: (_) => _pickMonth(),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Rentang Kustom'),
                  selected: _period == _Period.custom,
                  onSelected: (_) => _pickCustom(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Periode: ${formatDate(_from)} — ${formatDate(_to)}',
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),

          if (_loading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              ),
            )
          else if (_summary == null)
            const Text('Tidak ada data')
          else ...[
            // KPI Financial Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Omzet (Lunas)',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          formatCurrency(_summary!.omzet),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryLight],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Komisi Anda',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          formatCurrency(_summary!.komisi),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFDE68A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Breakdown Per Villa
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rincian Per Villa',
                    style: Theme.of(context).textTheme.titleMedium),
                Text('${_summary!.byVilla.length} Villa',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 10),

            if (_summary!.byVilla.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.receipt_long_outlined,
                            size: 48, color: Colors.grey.shade400),
                        const SizedBox(height: 8),
                        const Text('Belum ada transaksi invoice lunas di periode ini'),
                      ],
                    ),
                  ),
                ),
              )
            else
              Card(
                clipBehavior: Clip.antiAlias,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(
                        AppColors.primary.withValues(alpha: 0.05)),
                    columns: const [
                      DataColumn(
                          label: Text('Nama Villa',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Booking',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          numeric: true),
                      DataColumn(
                          label: Text('Total Omzet',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          numeric: true),
                      DataColumn(
                          label: Text('Komisi Marketer',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary)),
                          numeric: true),
                    ],
                    rows: _summary!.byVilla
                        .map((r) => DataRow(cells: [
                              DataCell(Text(r.villaName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600))),
                              DataCell(Text('${r.bookingCount}x')),
                              DataCell(Text(formatCurrency(r.omzet))),
                              DataCell(Text(
                                formatCurrency(r.komisi),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              )),
                            ]))
                        .toList(),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
