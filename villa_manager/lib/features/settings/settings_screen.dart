import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/theme/app_theme.dart';
import '../../data/database/app_database.dart';
import '../../data/database/dummy_data_seeder.dart';
import '../../services/photo_storage_service.dart';
import '../villa/villa_providers.dart';
import 'settings_providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _businessName = TextEditingController();
  final _tagline = TextEditingController();
  final _adminName = TextEditingController();
  final _adminContact = TextEditingController();
  final _bankAccounts = TextEditingController();
  final _footerNote = TextEditingController();
  final _templateTeaser = TextEditingController();
  final _templateDetail = TextEditingController();
  final _templateButler = TextEditingController();
  String _logoPath = '';
  String _savedLogoPath = '';
  bool _loaded = false;
  bool _saving = false;

  void _loadSettings(AppSetting settings) {
    _businessName.text = settings.businessName;
    _tagline.text = settings.tagline;
    _logoPath = settings.logoPath;
    _savedLogoPath = settings.logoPath;
    _adminName.text = settings.adminName;
    _adminContact.text = settings.adminContact;
    _bankAccounts.text = settings.bankAccounts;
    _footerNote.text = settings.invoiceFooterNote;
    _templateTeaser.text = settings.templateTeaser;
    _templateDetail.text = settings.templateDetail;
    _templateButler.text = settings.templateButlerNotification;
    _loaded = true;
  }

  Future<void> _discardDraftLogo() async {
    final path = _logoPath;
    if (path.isNotEmpty && path != _savedLogoPath) {
      await PhotoStorageService().deleteFile(path);
    }
  }

  @override
  void dispose() {
    unawaited(_discardDraftLogo());
    _businessName.dispose();
    _tagline.dispose();
    _adminName.dispose();
    _adminContact.dispose();
    _bankAccounts.dispose();
    _footerNote.dispose();
    _templateTeaser.dispose();
    _templateDetail.dispose();
    _templateButler.dispose();
    super.dispose();
  }

  Future<void> _pickLogo() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked == null) return;
    final storage = PhotoStorageService();
    final savedPath = await storage.importPhoto(picked.path);
    if (!mounted) {
      await storage.deleteFile(savedPath);
      return;
    }
    if (_logoPath.isNotEmpty && _logoPath != _savedLogoPath) {
      await storage.deleteFile(_logoPath);
    }
    setState(() => _logoPath = savedPath);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(settingsRepoProvider)
          .updateSettings(
            businessName: _businessName.text.trim(),
            tagline: _tagline.text.trim(),
            logoPath: _logoPath,
            adminName: _adminName.text.trim(),
            adminContact: _adminContact.text.trim(),
            bankAccounts: _bankAccounts.text.trim(),
            invoiceFooterNote: _footerNote.text.trim(),
            templateTeaser: _templateTeaser.text.trim(),
            templateDetail: _templateDetail.text.trim(),
            templateButlerNotification: _templateButler.text.trim(),
          );
      if (_savedLogoPath.isNotEmpty && _savedLogoPath != _logoPath) {
        await PhotoStorageService().deleteFile(_savedLogoPath);
      }
      _savedLogoPath = _logoPath;
      if (!mounted) return;
      ref.invalidate(appSettingsProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua profil, logo & template WA berhasil disimpan'),
          backgroundColor: AppColors.availableGreen,
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal menyimpan: $e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String _renderPreview(String template, {bool isButler = false}) {
    if (template.isEmpty)
      return '(Ketik template di atas untuk melihat preview)';
    if (isButler) {
      return template
          .replaceAll('{nama_penjaga}', 'Bli Kadek')
          .replaceAll('{nama_villa}', 'Villa Asmara Ubud')
          .replaceAll('{nama_tamu}', 'Dr. Hendra Gunawan')
          .replaceAll('{kontak_tamu}', '081809988776')
          .replaceAll('{tgl_checkin}', '25 Agu 2026')
          .replaceAll('{tgl_checkout}', '28 Agu 2026')
          .replaceAll('{jumlah_malam}', '3');
    }
    return template
        .replaceAll('{nama_villa}', 'Villa Asmara Ubud')
        .replaceAll('{lokasi}', 'Ubud, Gianyar, Bali')
        .replaceAll(
          '{deskripsi}',
          'Villa bambu eco-luxury 3 kamar dengan infinity pool pemandangan sawah terasering.',
        )
        .replaceAll(
          '{keunggulan}',
          '• Infinity Pool Menghadap Lembah\n• 100% Eco Bamboo Architecture\n• Floating Breakfast',
        )
        .replaceAll(
          '{fasilitas}',
          '• 3 Kamar Tidur AC\n• Private Pool\n• WiFi Cepat\n• Kitchen Set',
        )
        .replaceAll(
          '{aturan}',
          'No indoor smoking, Musik santai maks 22:00, Maks 6 orang.',
        )
        .replaceAll('{harga_weekday}', 'Rp 2.800.000')
        .replaceAll('{harga_weekend}', 'Rp 3.200.000')
        .replaceAll('{harga_high_season}', 'Rp 4.500.000')
        .replaceAll(
          '{nama_admin}',
          _adminName.text.isNotEmpty ? _adminName.text : 'Admin',
        )
        .replaceAll(
          '{kontak_admin}',
          _adminContact.text.isNotEmpty ? _adminContact.text : '08123456789',
        );
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(appSettingsProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pengaturan & Profil'),
          bottom: const TabBar(
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: [
              Tab(
                icon: Icon(Icons.storefront, size: 18),
                text: 'Profil & Logo',
              ),
              Tab(
                icon: Icon(Icons.chat_outlined, size: 18),
                text: 'Template WA',
              ),
            ],
          ),
        ),
        body: settingsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('$e')),
          data: (s) {
            if (!_loaded) {
              _loadSettings(s);
            }

            return Form(
              key: _formKey,
              child: TabBarView(
                children: [
                  // Tab 1: Profil, Logo & Rekening
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Logo Box Section
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              // Logo Image Thumbnail
                              Container(
                                width: 68,
                                height: 68,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceSubtle,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child:
                                    _logoPath.isNotEmpty &&
                                        File(_logoPath).existsSync()
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          File(_logoPath),
                                          cacheWidth: 204,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const Center(
                                        child: Icon(
                                          Icons.image_outlined,
                                          color: Colors.grey,
                                          size: 28,
                                        ),
                                      ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Logo Usaha / Agency',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    const Text(
                                      'Tampil otomatis di pojok atas Invoice PDF & Brosur',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        FilledButton.tonalIcon(
                                          style: FilledButton.styleFrom(
                                            visualDensity:
                                                VisualDensity.compact,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                          ),
                                          onPressed: _pickLogo,
                                          icon: const Icon(
                                            Icons.upload,
                                            size: 14,
                                          ),
                                          label: Text(
                                            _logoPath.isNotEmpty
                                                ? 'Ganti Logo'
                                                : 'Pilih Logo',
                                          ),
                                        ),
                                        if (_logoPath.isNotEmpty) ...[
                                          const SizedBox(width: 8),
                                          IconButton(
                                            tooltip: 'Hapus Logo',
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              color: Colors.red,
                                              size: 18,
                                            ),
                                            onPressed: () async {
                                              final removed = _logoPath;
                                              setState(() => _logoPath = '');
                                              if (removed != _savedLogoPath) {
                                                await PhotoStorageService()
                                                    .deleteFile(removed);
                                              }
                                            },
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Identitas Usaha / Brand',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _businessName,
                        decoration: const InputDecoration(
                          labelText: 'Nama Usaha / Agency Marketer *',
                          hintText: 'Mis: Bali Tropical Villa Management',
                          prefixIcon: Icon(Icons.business_outlined, size: 20),
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Wajib diisi'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _tagline,
                        decoration: const InputDecoration(
                          labelText: 'Tagline / Sub-header Invoice',
                          hintText: 'Mis: GUEST FOLIO & OFFICIAL INVOICE',
                          prefixIcon: Icon(Icons.subtitles_outlined, size: 20),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _adminName,
                              decoration: const InputDecoration(
                                labelText: 'Nama Admin / PIC',
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _adminContact,
                              decoration: const InputDecoration(
                                labelText: 'No. WA Admin',
                                prefixIcon: Icon(
                                  Icons.phone_outlined,
                                  size: 20,
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Rekening Pembayaran Tamu',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Daftar rekening tujuan transfer DP & Pelunasan',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _bankAccounts,
                        decoration: const InputDecoration(
                          labelText: 'Daftar Rekening Bank & Atas Nama',
                          hintText:
                              '- BCA: 123-456-7890 a.n. Villa Manager\n- Mandiri: 987-654-3210 a.n. Villa Manager',
                          alignLabelWithHint: true,
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Catatan Kaki Invoice (Terms / Kebijakan)',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _footerNote,
                        decoration: const InputDecoration(
                          labelText: 'Catatan Bawah Invoice',
                          hintText:
                              'Harap simpan bukti pembayaran dan tunjukkan saat proses check-in.',
                          alignLabelWithHint: true,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 24),
                      Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.backup_outlined,
                            color: AppColors.primary,
                          ),
                          title: const Text('Backup Data Offline (ZIP)'),
                          subtitle: const Text(
                            'Export seluruh data & foto villa ke file ZIP',
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),
                          onTap: () async {
                            final restored = await context.push<bool>(
                              '/settings/export',
                            );
                            if (restored != true || !mounted) return;
                            await _discardDraftLogo();
                            if (!mounted) return;
                            setState(() => _loaded = false);
                            ref.invalidate(appSettingsProvider);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Backup berhasil dipulihkan.'),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.description_outlined),
                          title: const Text('Lisensi Perangkat Lunak'),
                          subtitle: const Text(
                            'Lihat lisensi font dan komponen pihak ketiga',
                          ),
                          onTap: () => showLicensePage(
                            context: context,
                            applicationName: 'VillaPro',
                            applicationVersion: '1.0.0',
                          ),
                        ),
                      ),
                      if (kDebugMode && Platform.isLinux) ...[
                        const SizedBox(height: 10),
                        Card(
                          color: AppColors.goldBg,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: AppColors.gold.withValues(alpha: 0.4),
                            ),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.auto_awesome,
                              color: Color(0xFF8D6E63),
                            ),
                            title: const Text(
                              'Muat Data Contoh / Demo (4 Villa)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: const Text(
                              'Isi katalog dengan 4 villa lengkap, foto, booking aktif & invoice',
                            ),
                            trailing: const Icon(Icons.download, size: 18),
                            onTap: () async {
                              final db = ref.read(databaseProvider);
                              await DummyDataSeeder.seedIfEmpty(db);
                              ref.invalidate(villaListProvider);
                              ref.invalidate(appSettingsProvider);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Data demo berhasil dimuat!'),
                                    backgroundColor: AppColors.availableGreen,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                      const SizedBox(height: 28),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _saving ? null : _save,
                        icon: const Icon(Icons.save),
                        label: Text(
                          _saving ? 'Menyimpan...' : 'Simpan Profil & Logo',
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),

                  // Tab 2: Custom Template WA dengan LIVE PREVIEW
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.goldBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.gold.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.auto_awesome,
                                  color: Color(0xFF8D6E63),
                                  size: 18,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Tag Variabel Otomatis:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF8D6E63),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              '{nama_villa}  {lokasi}  {deskripsi}  {keunggulan}  {fasilitas}  {aturan}  {harga_weekday}  {harga_weekend}  {harga_high_season}  {nama_admin}  {kontak_admin}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF8D6E63),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 1. Template Teaser Singkat
                      Text(
                        '1. Template Teaser Singkat',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _templateTeaser,
                        decoration: const InputDecoration(
                          hintText: 'Format pesan singkat untuk chat awal…',
                          alignLabelWithHint: true,
                        ),
                        maxLines: 4,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 6),
                      _LivePreviewBox(
                        title: 'Live Preview (Teaser Singkat):',
                        renderedText: _renderPreview(_templateTeaser.text),
                      ),

                      const SizedBox(height: 24),

                      // 2. Template Detail Lengkap
                      Text(
                        '2. Template Detail Lengkap',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _templateDetail,
                        decoration: const InputDecoration(
                          hintText: 'Format info lengkap fasilitas & harga…',
                          alignLabelWithHint: true,
                        ),
                        maxLines: 8,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 6),
                      _LivePreviewBox(
                        title: 'Live Preview (Detail Lengkap):',
                        renderedText: _renderPreview(_templateDetail.text),
                      ),

                      const SizedBox(height: 24),

                      // 3. Template Butler
                      Text(
                        '3. Template Notifikasi Check-in ke Penjaga Villa',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Variabel: {nama_penjaga} {nama_villa} {nama_tamu} {kontak_tamu} {tgl_checkin} {tgl_checkout} {jumlah_malam}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _templateButler,
                        decoration: const InputDecoration(
                          hintText:
                              'Format notifikasi persiapan tamu ke butler…',
                          alignLabelWithHint: true,
                        ),
                        maxLines: 5,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 6),
                      _LivePreviewBox(
                        title: 'Live Preview (Pesan ke Penjaga):',
                        renderedText: _renderPreview(
                          _templateButler.text,
                          isButler: true,
                        ),
                      ),

                      const SizedBox(height: 28),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _saving ? null : _save,
                        icon: const Icon(Icons.save),
                        label: Text(
                          _saving ? 'Menyimpan...' : 'Simpan Template WhatsApp',
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LivePreviewBox extends StatelessWidget {
  const _LivePreviewBox({required this.title, required this.renderedText});

  final String title;
  final String renderedText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFECE5DD), // Classic WhatsApp bubble background
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD4C8BC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.visibility, size: 14, color: Color(0xFF075E54)),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF075E54),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              renderedText,
              style: const TextStyle(
                fontSize: 12,
                height: 1.4,
                color: Colors.black87,
                fontFamily: 'sans-serif',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
