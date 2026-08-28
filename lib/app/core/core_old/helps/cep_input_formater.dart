import 'package:flutter/services.dart';

class CepInputFormatters extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text =
        newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove não numéricos

    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String formatted;
    if (text.length <= 5) {
      formatted = text;
    } else if (text.length <= 8) {
      formatted = '${text.substring(0, 5)}-${text.substring(5)}';
    } else {
      formatted =
          '${text.substring(0, 5)}-${text.substring(5, 8)}'; // Limita a 8 dígitos
    }

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

String removeCepMask(String maskedCep) {
  return maskedCep.replaceAll(RegExp(r'\D'), '');
}
