import 'package:flutter_test/flutter_test.dart';
import 'package:villa_manager/core/utils/formatters.dart';

void main() {
  test('formatCurrency has Rp prefix and thousand dot', () {
    expect(formatCurrency(1500000), 'Rp 1.500.000');
    expect(formatCurrency(0), 'Rp 0');
    expect(formatCurrency(75000), 'Rp 75.000');
  });

  test('parseCurrency strips non-digits', () {
    expect(parseCurrency('Rp 1.500.000'), 1500000);
    expect(parseCurrency('1.500.000'), 1500000);
    expect(parseCurrency('1500000'), 1500000);
    expect(parseCurrency(''), 0);
  });

  test('VillaCommission calculations', () {
    const pct = VillaCommission(type: 'percent', percent: 10, fixed: 0);
    expect(pct.amountFor(2000000), 200000);
    expect(pct.label, '10%');

    const fixed = VillaCommission(type: 'fixed', percent: 0, fixed: 150000);
    expect(fixed.amountFor(2000000), 150000);
    expect(fixed.label, 'Rp 150.000');
  });
}
