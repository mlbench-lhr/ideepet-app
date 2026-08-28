import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/core_old/helps/validate_textfield.dart';

class NewPasswordController extends GetxController {
  final NavigationService _navigationService;
  final NewPasswordRepository _repository;
  NewPasswordController(
    this._navigationService,
    this._repository,
  );

  late final String code;

  final isLoading = false.obs;

  final canContinue = false.obs;
  final passwordError = ''.obs;
  final confirmPasswordError = ''.obs;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      code = Get.arguments;
    }
  }

  void back() => _navigationService.back();

  void validate() {
    passwordError(validatePassword(passwordController.text));
    if (passwordError() == '') {
      if (passwordController.text == confirmPasswordController.text) {
        confirmPasswordError('');
        canContinue(true);
      } else {
        confirmPasswordError('As senhas não conferem');
        canContinue(false);
      }
    } else {
      confirmPasswordError('');
      canContinue(false);
    }
  }

  Future<void> next() async {
    isLoading(true);

    final request =
        NewPasswordRequest(password: passwordController.text, code: code);
    final response = await _repository.changePassword(request);
    isLoading(false);
    if (response.success) {
      _navigationService
          .offAllNamed(NewPasswordSuccessRoutes.newPasswordSuccess);

      return;
    }
    showError(message: response.errorMessages?.first ?? null);
  }
}
