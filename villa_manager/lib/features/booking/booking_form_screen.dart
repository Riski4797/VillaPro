import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/booking_utils.dart';
import '../../core/utils/currency_input_formatter.dart';
import '../../core/utils/formatters.dart';
import '../../data/database/app_database.dart';
import '../villa/villa_providers.dart';
import 'booking_providers.dart';

class BookingFormScreen extends ConsumerStatefulWidget {
  const BookingFormScreen({super.key, this.bookingId});
  final String? bookingId;

  @override
  ConsumerState<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends ConsumerState<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _guestName = TextEditingController();
  final _guestContact = TextEditingController();
  final _price = TextEditingController();
  final _notes = TextEditingController();
  String? _villaId;
  DateTime? _checkIn;
  DateTime? _checkOut;
  String _status = 'confirmed';
  bool _loaded = false;
  bool _saving = false;
  Future<Booking?>? _bookingFuture;

  bool get _isEdit => widget.bookingId != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      _bookingFuture = ref.read(bookingRepoProvider).getById(widget.bookingId!);
    }
  }

  @override
  void dispose() {
    _guestName.dispose();
    _guestContact.dispose();
    _price.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isCheckIn}) async {
    final initial = isCheckIn
        ? (_checkIn ?? DateTime.now())
        : (_checkOut ??
              (_checkIn ?? DateTime.now()).add(const Duration(days: 1)));
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() {
      if (isCheckIn) {
        _checkIn = picked;
        if (_checkOut != null && !_checkOut!.isAfter(picked)) {
          _checkOut = picked.add(const Duration(days: 1));
        }
      } else {
        _checkOut = picked;
      }
    });
  }

  Future<void> _onVillaChanged(String? id) async {
    setState(() => _villaId = id);
    if (id == null || _isEdit) return;
    final v = await ref.read(villaRepoProvider).getById(id);
    if (v != null && mounted) {
      setState(() => _price.text = formatCurrencyInput(v.priceWeekday));
    }
  }

  void _load(Booking b) {
    _villaId = b.villaId;
    _guestName.text = b.guestName;
    _guestContact.text = b.guestContact;
    _price.text = formatCurrencyInput(b.pricePerNightSnapshot);
    _notes.text = b.notes;
    _checkIn = b.checkIn;
    _checkOut = b.checkOut;
    _status = b.status;
    _loaded = true;
  }

  Future<void> _save() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;
    if (_villaId == null || _checkIn == null || _checkOut == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Lengkapi villa & tanggal')));
      return;
    }
    if (!_checkOut!.isAfter(_checkIn!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check-out harus setelah check-in')),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      final repo = ref.read(bookingRepoProvider);
      var allowOverlap = false;
      if (_status == 'confirmed') {
        final overlaps = await repo.findOverlaps(
          villaId: _villaId!,
          checkIn: _checkIn!,
          checkOut: _checkOut!,
          excludeId: widget.bookingId,
        );
        if (!mounted) return;
        if (overlaps.isNotEmpty) {
          final detail = overlaps
              .map(
                (o) =>
                    '- ${o.guestName}: ${formatDate(o.checkIn)} s.d. ${formatDate(o.checkOut)}',
              )
              .join('\n');
          final proceed = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Bentrok tanggal'),
              content: Text('Ada booking lain di villa yang sama:\n\n$detail'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('Batal'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text('Tetap Simpan'),
                ),
              ],
            ),
          );
          if (proceed != true) return;
          allowOverlap = true;
        }
      }

      await repo.upsert(
        id: widget.bookingId,
        villaId: _villaId!,
        guestName: _guestName.text.trim(),
        guestContact: _guestContact.text.trim(),
        checkIn: _checkIn!,
        checkOut: _checkOut!,
        pricePerNightSnapshot: parseCurrency(_price.text),
        status: _status,
        notes: _notes.text.trim(),
        allowOverlap: allowOverlap,
      );
      if (mounted) context.go('/bookings');
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking gagal disimpan: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isEdit && !_loaded) {
      return FutureBuilder(
        future: _bookingFuture,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snap.hasError) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: Text('Gagal memuat booking: ${snap.error}')),
            );
          }
          final b = snap.data;
          if (b == null) {
            return const Scaffold(
              body: Center(child: Text('Booking tidak ditemukan')),
            );
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && !_loaded) setState(() => _load(b));
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      );
    }

    final villasAsync = ref.watch(allVillasProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Booking' : 'Tambah Booking'),
        actions: [
          if (_isEdit)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () async {
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Hapus booking?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Batal'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Hapus'),
                      ),
                    ],
                  ),
                );
                if (ok == true && mounted) {
                  try {
                    await ref
                        .read(bookingRepoProvider)
                        .delete(widget.bookingId!);
                    if (mounted) context.go('/bookings');
                  } catch (_) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Booking yang sudah memiliki invoice tidak dapat dihapus.',
                          ),
                        ),
                      );
                    }
                  }
                }
              },
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            villasAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('$e'),
              data: (villas) => DropdownButtonFormField<String>(
                // ignore: deprecated_member_use — controlled dropdown needs value
                value: _villaId,
                decoration: const InputDecoration(labelText: 'Villa *'),
                items: villas
                    .map(
                      (v) => DropdownMenuItem(value: v.id, child: Text(v.name)),
                    )
                    .toList(),
                onChanged: _onVillaChanged,
                validator: (v) => v == null ? 'Wajib' : null,
              ),
            ),
            TextFormField(
              controller: _guestName,
              decoration: const InputDecoration(labelText: 'Nama tamu *'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Wajib' : null,
            ),
            TextFormField(
              controller: _guestContact,
              decoration: const InputDecoration(
                labelText: 'Kontak WA (08… / 62…)',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickDate(isCheckIn: true),
                    child: Text(
                      _checkIn == null ? 'Check-in' : formatDate(_checkIn!),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickDate(isCheckIn: false),
                    child: Text(
                      _checkOut == null ? 'Check-out' : formatDate(_checkOut!),
                    ),
                  ),
                ),
              ],
            ),
            if (_checkIn != null && _checkOut != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '${nightsBetween(_checkIn!, _checkOut!)} malam · '
                  'Total ${formatCurrency(parseCurrency(_price.text) * nightsBetween(_checkIn!, _checkOut!))}',
                ),
              ),
            TextFormField(
              controller: _price,
              decoration: const InputDecoration(
                labelText: 'Harga / malam (snapshot)',
                prefixText: 'Rp ',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [CurrencyInputFormatter()],
              onChanged: (_) => setState(() {}),
            ),
            if (_isEdit)
              DropdownButtonFormField<String>(
                // ignore: deprecated_member_use — controlled dropdown needs value
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(
                    value: 'confirmed',
                    child: Text('Confirmed'),
                  ),
                  DropdownMenuItem(
                    value: 'cancelled',
                    child: Text('Cancelled'),
                  ),
                ],
                onChanged: (v) => setState(() => _status = v ?? 'confirmed'),
              ),
            TextFormField(
              controller: _notes,
              decoration: const InputDecoration(labelText: 'Catatan'),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: Text(_saving ? 'Menyimpan...' : 'Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
