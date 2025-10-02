import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  static final _formatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: r'R$',
  );

  static String format(double value) {
    return _formatter.format(value);
  }

  static double unformat(String text) {
    print('text = $text');
    if (text.isEmpty) return 0;
    try {
      final cleanedText = text.replaceAll(r'R$', '').trim().replaceAll('.', '');
      final parsableText = cleanedText.replaceAll(',', '.');
      return double.tryParse(parsableText) ?? 0.0;
    } catch (e) {
      return 0;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    if (newText.isEmpty) {
      return const TextEditingValue(
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    final value = double.parse(newText) / 100;
    final formattedText = _formatter.format(value);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
