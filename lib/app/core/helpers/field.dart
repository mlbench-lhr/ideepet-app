import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidatedField {
  final TextEditingController controller = TextEditingController();
  final RxString error = ''.obs;
  final String? Function(String value)? validator;

  ValidatedField({this.validator});

  void validate() {
    if (validator != null) {
      error.value = validator!(controller.text) ?? '';
    }
  }

  void validateIfNotEmpty() {
    final text = controller.text.trim();
    if (text.isEmpty) {
      error.value = '';
    } else {
      validate();
    }
  }

  void dispose() {
    controller.dispose();
  }
}
