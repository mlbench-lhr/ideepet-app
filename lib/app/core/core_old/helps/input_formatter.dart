import 'package:flutter/services.dart';


class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove não numéricos

    if (text.isEmpty) return newValue.copyWith(text: '');

    String formatted;
    int offset = newValue.selection.baseOffset;

    if (text.length <= 2) {
      formatted = '($text';
    } else if (text.length <= 6) {
      formatted = '(${text.substring(0, 2)}) ${text.substring(2)}';
    } else if (text.length <= 10) {
      formatted =
          '(${text.substring(0, 2)}) ${text.substring(2, 6)}-${text.substring(6)}';
    } else {
      formatted =
          '(${text.substring(0, 2)}) ${text.substring(2, 7)}-${text.substring(7, 11)}';
    }

    // Ajusta a posição do cursor para evitar a duplicação do primeiro número
    int newOffset = offset + (formatted.length - newValue.text.length);
    newOffset = newOffset.clamp(0, formatted.length);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}

String removePhoneMask(String maskedPhone) {
  return maskedPhone.replaceAll(RegExp(r'\D'), '');
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text =
        newValue.text.replaceAll(RegExp(r'[^0-9]'), ''); // Remove não numéricos

    if (text.length > 8) {
      text = text.substring(0, 8); // Limita a 8 dígitos
    }

    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) {
        formatted += '/';
      }
      formatted += text[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

String removeDateFormatting(String date) {
  return date.replaceAll(RegExp(r'[^0-9]'), '');
}
