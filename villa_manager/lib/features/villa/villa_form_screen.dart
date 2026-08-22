import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/currency_input_formatter.dart';
import '../../core/utils/formatters.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/villa_repository.dart';
import 'villa_providers.dart';

class VillaFormScreen extends ConsumerStatefulWidget {
  const VillaFormScreen({super.key, this.villaId});
  final String? villaId;

  @override
  ConsumerState<VillaFormScreen> createState() => _VillaFormScreenState();
}

class _VillaFormScreenState extends ConsumerState<VillaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _location = TextEditingController();
  final _ownerName = TextEditingController();
  final _ownerContact = TextEditingController();
  final _ownerBank = TextEditingController();
  final _butlerName = TextEditingController();
  final _butlerContact = TextEditingController();
  final _description = TextEditingController();
  final _usps = TextEditingController();
  final _amenities = TextEditingController();
  final _houseRules = TextEditingController();
  final _priceWeekday = TextEditingController();
  final _priceWeekend = TextEditingController();
  final _priceHighSeason = TextEditingController();
  final _commissionPct = TextEditingController(text: '0');
  final _commissionFixed = TextEditingController();
  final _privateNotes = TextEditingController();
  String _commissionType = 'percent';
  bool _isButlerSameAsOwner = false;
  bool _isActive = true;
  bool _loaded = false;
  bool _saving = false;

  bool get _isEdit => widget.villaId != null;

  @override
  void dispose() {
    for (final c in [
      _name,
      _location,
      _ownerName,
      _ownerContact,
      _ownerBank,
      _butlerName,
      _butlerContact,
      _description,
      _usps,
      _amenities,
      _houseRules,
      _priceWeekday,
      _priceWeekend,
      _priceHighSeason,
      _commissionPct,
      _commissionFixed,
      _privateNotes,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _fillFrom(Villa v, {bool keepName = true}) {
    if (keepName) _name.text = v.name;
    _location.text = v.location;
    _ownerName.text = v.ownerName;
    _ownerContact.text = v.ownerContact;
    _ownerBank.text = v.ownerBank;
    _butlerName.text = v.butlerName;
    _butlerContact.text = v.butlerContact;
    _isButlerSameAsOwner = v.isButlerSameAsOwner;
    _description.text = v.description;
    _usps.text = VillaRepository.decodeList(v.uniqueSellingPoints).join('\n');
    _amenities.text = VillaRepository.decodeList(v.amenities).join('\n');
    _houseRules.text = v.houseRules;
    _priceWeekday.text = formatCurrencyInput(v.priceWeekday);
    _priceWeekend.text = formatCurrencyInput(v.priceWeekend);
    _priceHighSeason.text = formatCurrencyInput(v.priceHighSeason);
    _commissionType = v.commissionType;
    _commissionPct.text =
        v.commissionPercent == v.commissionPercent.roundToDouble()
        ? '${v.commissionPercent.toInt()}'
        : '${v.commissionPercent}';
    _commissionFixed.text = formatCurrencyInput(v.commissionFixed);
    _privateNotes.text = v.privateNotes;
    _isActive = v.isActive;
  }

  Future<void> _copyFromOther() async {
    final list = await ref
        .read(villaRepoProvider)
        .watchAll(activeOnly: false)
        .first;
    if (!mounted || list.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Belum ada villa untuk disalin')),
        );
      }
      return;
    }
    final picked = await showDialog<Villa>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Salin dari villa lain'),
        children: list
            .map(
              (v) => SimpleDialogOption(
                onPressed: () => Navigator.pop(ctx, v),
                child: Text(v.name),
              ),
            )
            .toList(),
      ),
    );
    if (picked != null) setState(() => _fillFrom(picked, keepName: false));
  }

  List<String> _lines(String raw) =>
      raw.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final butlerN = _isButlerSameAsOwner
          ? _ownerName.text.trim()
          : _butlerName.text.trim();
      final butlerC = _isButlerSameAsOwner
          ? _ownerContact.text.trim()
          : _butlerContact.text.trim();

      final id = await ref
          .read(villaRepoProvider)
          .upsert(
            id: widget.villaId,
            name: _name.text.trim(),
            location: _location.text.trim(),
            ownerName: _ownerName.text.trim(),
            ownerContact: _ownerContact.text.trim(),
            ownerBank: _ownerBank.text.trim(),
            butlerName: butlerN,
            butlerContact: butlerC,
            isButlerSameAsOwner: _isButlerSameAsOwner,
            isActive: _isActive,
            description: _description.text.trim(),
            usps: _lines(_usps.text),
            amenities: _lines(_amenities.text),
            houseRules: _houseRules.text.trim(),
            priceWeekday: parseCurrency(_priceWeekday.text),
            priceWeekend: parseCurrency(_priceWeekend.text),
            priceHighSeason: parseCurrency(_priceHighSeason.text),
            commissionPercent:
                double.tryParse(_commissionPct.text.replaceAll(',', '.')) ?? 0,
            commissionType: _commissionType,
            commissionFixed: parseCurrency(_commissionFixed.text),
            privateNotes: _privateNotes.text.trim(),
          );

      ref.invalidate(villaDetailProvider(id));
      ref.invalidate(villaThumbProvider(id));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEdit
                ? 'Perubahan villa berhasil disimpan'
                : 'Villa baru berhasil ditambahkan',
          ),
          backgroundColor: Colors.green,
        ),
      );
      if (_isEdit && context.canPop()) {
        context.pop();
      } else {
        context.go('/villas/$id');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal simpan: $e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isEdit && !_loaded) {
      final async = ref.watch(villaDetailProvider(widget.villaId!));
      return async.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
        data: (v) {
          if (v == null) {
            return const Scaffold(
              body: Center(child: Text('Villa tidak ditemukan')),
            );
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_loaded) {
              _fillFrom(v);
              setState(() => _loaded = true);
            }
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Data Villa' : 'Tambah Villa Baru'),
        actions: [
          if (!_isEdit)
            TextButton.icon(
              onPressed: _copyFromOther,
              icon: const Icon(Icons.copy_outlined, size: 16),
              label: const Text('Salin dari…'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Section Informasi Umum
            Text(
              'Informasi Properti',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Nama Villa *',
                hintText: 'Mis: Villa Sunset Ubud',
                prefixIcon: Icon(Icons.villa_outlined, size: 20),
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Nama villa wajib diisi'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _location,
              decoration: const InputDecoration(
                labelText: 'Lokasi / Area',
                hintText: 'Mis: Jl. Raya Ubud, Gianyar, Bali',
                prefixIcon: Icon(Icons.location_on_outlined, size: 20),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _description,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Villa',
                hintText:
                    'Deskripsi suasana, jumlah kamar, dan daya tarik villa…',
                alignLabelWithHint: true,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _usps,
              decoration: const InputDecoration(
                labelText: 'Keunggulan / USP (1 per baris)',
                hintText:
                    'Private Infinity Pool\nView Sawah Hijau\nDekat Pantai',
                alignLabelWithHint: true,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amenities,
              decoration: const InputDecoration(
                labelText: 'Fasilitas Lengkap (1 per baris)',
                hintText: 'WiFi Cepat\nAC di Semua Kamar\nKitchen Set\nBathtub',
                alignLabelWithHint: true,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _houseRules,
              decoration: const InputDecoration(
                labelText: 'Aturan Menginap (House Rules)',
                hintText: 'No Smoking in Room, No Loud Music after 22:00',
                alignLabelWithHint: true,
              ),
              maxLines: 2,
            ),

            const SizedBox(height: 24),

            // Section Tarif Sewa
            Text(
              'Tarif Sewa (Publish Rate)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _priceField(_priceWeekday, 'Weekday')),
                const SizedBox(width: 8),
                Expanded(child: _priceField(_priceWeekend, 'Weekend')),
                const SizedBox(width: 8),
                Expanded(child: _priceField(_priceHighSeason, 'High Season')),
              ],
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Status Aktif (Tampil di Katalog)'),
              subtitle: const Text(
                'Nonaktifkan jika villa sedang renovasi / jeda sewa',
              ),
              value: _isActive,
              onChanged: (v) => setState(() => _isActive = v),
            ),

            const SizedBox(height: 24),

            // Section Catatan Pribadi Marketer & Owner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lock_outline, color: Color(0xFF8D6E63), size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Area Rahasia Marketer\n(Tidak akan pernah terlihat oleh customer)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8D6E63),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Owner Details
            Text(
              '1. Data Pemilik Villa (Owner)',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _ownerName,
              decoration: const InputDecoration(
                labelText: 'Nama Owner',
                prefixIcon: Icon(Icons.person_outline, size: 20),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _ownerContact,
              decoration: const InputDecoration(
                labelText: 'No. WA Owner',
                prefixIcon: Icon(Icons.phone_outlined, size: 20),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _ownerBank,
              decoration: const InputDecoration(
                labelText: 'Rekening Setoran Owner',
                hintText: 'BCA 1234567890 a.n. Pak Wayan',
                prefixIcon: Icon(Icons.account_balance_outlined, size: 20),
              ),
            ),

            const SizedBox(height: 20),

            // Butler / Penjaga Details
            Text(
              '2. Data Penjaga / Butler Villa (Di Lokasi)',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Penjaga / Butler adalah Owner sendiri'),
              value: _isButlerSameAsOwner,
              onChanged: (v) =>
                  setState(() => _isButlerSameAsOwner = v ?? false),
            ),
            if (!_isButlerSameAsOwner) ...[
              TextFormField(
                controller: _butlerName,
                decoration: const InputDecoration(
                  labelText: 'Nama Penjaga / Butler',
                  prefixIcon: Icon(Icons.badge_outlined, size: 20),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _butlerContact,
                decoration: const InputDecoration(
                  labelText: 'No. WA Penjaga Villa',
                  prefixIcon: Icon(Icons.phone_android_outlined, size: 20),
                ),
                keyboardType: TextInputType.phone,
              ),
            ],

            const SizedBox(height: 20),

            // Komisi Marketer
            Text(
              '3. Kesepakatan Komisi Marketer',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'percent', label: Text('Persen %')),
                ButtonSegment(value: 'fixed', label: Text('Nominal Rp')),
              ],
              selected: {_commissionType},
              onSelectionChanged: (s) =>
                  setState(() => _commissionType = s.first),
            ),
            const SizedBox(height: 10),
            if (_commissionType == 'percent')
              TextFormField(
                controller: _commissionPct,
                decoration: const InputDecoration(
                  labelText: 'Besaran Komisi (%)',
                  suffixText: '%',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              )
            else
              TextFormField(
                controller: _commissionFixed,
                decoration: const InputDecoration(
                  labelText: 'Nominal Komisi Tetap',
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [CurrencyInputFormatter()],
              ),

            const SizedBox(height: 12),
            TextFormField(
              controller: _privateNotes,
              decoration: const InputDecoration(
                labelText: 'Catatan Khusus Villa',
                hintText:
                    'Misal: Kunci cadangan ada di pos satpam, nego max 10%',
                alignLabelWithHint: true,
              ),
              maxLines: 2,
            ),

            const SizedBox(height: 32),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.save),
              label: Text(_saving ? 'Menyimpan...' : 'Simpan Data Villa'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _priceField(TextEditingController c, String label) {
    return TextFormField(
      controller: c,
      decoration: InputDecoration(labelText: label, prefixText: 'Rp '),
      keyboardType: TextInputType.number,
      inputFormatters: [CurrencyInputFormatter()],
    );
  }
}
