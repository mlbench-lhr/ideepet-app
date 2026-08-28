import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class LoginController extends GetxController {
  LoginController(
      this._repository, this.appStateService, this._navigationService);
  final AuthService _repository;
  final AppStateService appStateService;
  final NavigationService _navigationService;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final emailError = ''.obs;
  final passwordError = ''.obs;
  final messageError = ''.obs;

  final canProceed = false.obs;
  final isLoading = false.obs;

  void _validateEmailField() =>
      emailError(validateEmail(emailController.text) ?? '');

  void _validatePasswordField() =>
      passwordError(validatePassword(passwordController.text) ?? '');

  void validate() {
    _validateEmailField();
    _validatePasswordField();
    canProceed(emailError() == '' && passwordError() == '');
  }

  Future<void> signIn() async {
    isLoading(true);
    final request = SignInRequest(
      email: emailController.text,
      password: passwordController.text,
    );

    final result = await _repository.login(request);
    isLoading(false);

    switch (result.status) {
      case LoginStatus.success:
        appStateService.isLogged(true);
        _navigationService.offAllNamed(HomeRoutes.home);
        break;

      case LoginStatus.otpRequired:
        _navigationService.toNamed(OtpRoutes.otp, arguments: result.otpCode);
        break;

      case LoginStatus.error:
        showError(message: 'Erro ao tentar logar');
        break;
    }
  }

  void gotoCrteateAccount() =>
      _navigationService.toNamed(OnboardingRoutes.onboarding);

  void forgotPassword() =>
      _navigationService.toNamed(ForgotPasswordRoutes.forgotPassword);
}
