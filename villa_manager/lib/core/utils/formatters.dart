import 'package:intl/intl.dart';

// id_ID: titik ribuan, tanpa desimal → "Rp 1.500.000"
final _idr = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp ',
  decimalDigits: 0,
);
final _date = DateFormat('d MMM yyyy', 'id_ID');
final _digitsOnly = NumberFormat('#,###', 'id_ID');

String formatCurrency(int amount) => _idr.format(amount);

/// Input helper: "1500000" / "1.500.000" / "Rp 1.500.000" → 1500000
int parseCurrency(String raw) {
  final digits = raw.replaceAll(RegExp(r'[^\d]'), '');
  return int.tryParse(digits) ?? 0;
}

String formatCurrencyInput(int amount) =>
    amount <= 0 ? '' : _digitsOnly.format(amount);

String formatDate(DateTime d) => _date.format(d);

class VillaCommission {
  const VillaCommission({
    required this.type,
    required this.percent,
    required this.fixed,
  });
  final String type; // percent | fixed
  final double percent;
  final int fixed;

  int amountFor(int invoiceTotal) {
    if (type == 'fixed') return fixed;
    return (invoiceTotal * percent / 100).round();
  }

  String get label {
    if (type == 'fixed') return formatCurrency(fixed);
    final pct = percent == percent.roundToDouble()
        ? '${percent.toInt()}'
        : '$percent';
    return '$pct%';
  }
}
