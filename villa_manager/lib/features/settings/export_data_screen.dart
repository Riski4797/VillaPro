import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../services/export_service.dart';
import '../../services/notification_service.dart';
import '../villa/villa_providers.dart';

class ExportDataScreen extends ConsumerStatefulWidget {
  const ExportDataScreen({super.key});

  @override
  ConsumerState<ExportDataScreen> createState() => _ExportDataScreenState();
}

class _ExportDataScreenState extends ConsumerState<ExportDataScreen> {
  bool _busy = false;
  String? _message;

  Future<String?> _askPassword({required bool confirm}) async {
    final password = TextEditingController();
    final confirmation = TextEditingController();
    String? error;
    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(confirm ? 'Password Backup' : 'Buka Backup'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: password,
                autofocus: true,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  labelText: 'Password minimal 12 karakter',
                  helperText: 'Gunakan frasa unik yang mudah Anda ingat',
                ),
              ),
              if (confirm) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: confirmation,
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: const InputDecoration(
                    labelText: 'Ulangi password',
                  ),
                ),
              ],
              if (error != null) ...[
                const SizedBox(height: 8),
                Text(error!, style: const TextStyle(color: Colors.red)),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                if (password.text.trim().length < 12) {
                  setDialogState(() => error = 'Password minimal 12 karakter');
                } else if (confirm && password.text != confirmation.text) {
                  setDialogState(() => error = 'Konfirmasi tidak sama');
                } else {
                  Navigator.pop(dialogContext, password.text);
                }
              },
              child: const Text('Lanjut'),
            ),
          ],
        ),
      ),
    );
    password.dispose();
    confirmation.dispose();
    return result;
  }

  Future<void> _export() async {
    final password = await _askPassword(confirm: true);
    if (password == null || !mounted) return;
    final service = ExportService(ref.read(databaseProvider));

    setState(() {
      _busy = true;
      _message = null;
    });
    File? temporaryZip;
    try {
      temporaryZip = await service.buildZip(password);
      if (Platform.isAndroid) {
        await SharePlus.instance.share(
          ShareParams(
            title: 'Simpan Backup VillaPro',
            files: [
              XFile(
                temporaryZip.path,
                mimeType: 'application/zip',
                name: service.suggestedFileName(),
              ),
            ],
          ),
        );
      } else {
        final location = await getSaveLocation(
          suggestedName: service.suggestedFileName(),
        );
        if (location == null) return;
        await XFile(temporaryZip.path).saveTo(location.path);
      }
      if (mounted)
        setState(() => _message = 'Backup terenkripsi berhasil disimpan.');
    } catch (_) {
      if (mounted) setState(() => _message = 'Backup gagal dibuat.');
    } finally {
      if (temporaryZip != null && await temporaryZip.exists()) {
        await temporaryZip.delete();
      }
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _restore() async {
    const zipType = XTypeGroup(label: 'VillaPro Backup', extensions: ['zip']);
    final selected = await openFile(acceptedTypeGroups: const [zipType]);
    if (selected == null || !mounted) return;
    final password = await _askPassword(confirm: false);
    if (password == null || !mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Pulihkan backup?'),
        content: const Text(
          'Semua data saat ini akan diganti dengan isi backup. Proses ini tidak dapat dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Pulihkan'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final db = ref.read(databaseProvider);
      await ExportService(db).restore(File(selected.path), password);
      await NotificationService.instance.reconcileAfterRestore(db);
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _message = 'Restore gagal. Periksa file dan password.');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backup & Restore')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Backup mencakup seluruh villa, media, booking, invoice, pembayaran, profil, logo, dan template.',
          ),
          const SizedBox(height: 12),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Text(
                'File berisi data pribadi dan keuangan. Simpan password terpisah; backup tidak dapat dibuka tanpa password.',
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _busy ? null : _export,
            icon: const Icon(Icons.lock_outline),
            label: Text(_busy ? 'Memproses...' : 'Buat Backup Terenkripsi'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: _busy ? null : _restore,
            icon: const Icon(Icons.restore),
            label: const Text('Pulihkan dari Backup'),
          ),
          if (_message != null) ...[
            const SizedBox(height: 12),
            Text(_message!),
          ],
        ],
      ),
    );
  }
}
