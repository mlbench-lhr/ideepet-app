import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/core_old/helps/validate_textfield.dart';

class ForgotPasswordController extends GetxController {
  final AuthService _authService;
  final NavigationService _navigationService;
  final AppStateService _appStateService;

  ForgotPasswordController(
    this._authService,
    this._navigationService,
    this._appStateService,
  );

  TextEditingController emailController = TextEditingController();

  final emailError = ''.obs;
  final canContinue = false.obs;
  final isLoading = false.obs;

  void validate() {
    emailError(validateEmail(emailController.text));
    if (emailError() == '') {
      canContinue(true);
    }
  }

  Future<void> next() async {
    canContinue(false);
    isLoading(true);
    final response = await _authService.resenCodeToChangePassword(
        email: emailController.text);
    isLoading(false);
    if (response) {
      final params = OtpParam(email: emailController.text, isChanging: true);
      _appStateService.profile().email = emailController.text;
      _navigationService.offAllNamed(OtpRoutes.otp, arguments: params);
      return;
    }
    showError();
    canContinue(true);
  }

  void goToLogin() {
    _navigationService.offAllNamed(LoginRoutes.login);
  }
}
