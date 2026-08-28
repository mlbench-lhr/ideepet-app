import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:idee_pet/lib.dart';

class OtpController extends GetxController {
  final AuthService _authService;
  final NavigationService _navigationService;
  final OtpRepository _repository;
  final HomeRepository _homeRepository;

  OtpController(
    this._authService,
    this._navigationService,
    this._repository,
    this._homeRepository,
  );

  final sendCode = true.obs;
  late String code;

  final remainingTime = 300.obs;
  Timer? _timer;

  final canResendCode = false.obs;
  final isLoading = false.obs;
  final formattedTime = ''.obs;

  late final OtpParam? _otpParam;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments is OtpParam) {
        _otpParam = Get.arguments;
        code = '';
      }
      if (Get.arguments is String) {
        code = Get.arguments;
        _otpParam = null;
      }
      return;
    }
    _otpParam = null;
    code = '';
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    isLoading(true);

    startTimer();
    isLoading(false);
  }

  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();
  TextEditingController pin5 = TextEditingController();
  TextEditingController pin6 = TextEditingController();

  final pinString1 = ''.obs;
  final pinString2 = ''.obs;
  final pinString3 = ''.obs;
  final pinString4 = ''.obs;
  final pinString5 = ''.obs;
  final pinString6 = ''.obs;

  void setPin1(String value) => pinString1(value);
  void setPin2(String value) => pinString2(value);
  void setPin3(String value) => pinString3(value);
  void setPin4(String value) => pinString4(value);
  void setPin5(String value) => pinString5(value);
  void setPin6(String value) => pinString6(value);

  bool get isPinComplete {
    return pinString1.isNotEmpty &&
        pinString2.isNotEmpty &&
        pinString3.isNotEmpty &&
        pinString4.isNotEmpty &&
        pinString5.isNotEmpty &&
        pinString6.isNotEmpty;
  }

  void startTimer() {
    _timer?.cancel();
    remainingTime(300);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime.value--;
        int minutes = remainingTime.value ~/ 60;
        int seconds = remainingTime.value % 60;
        formattedTime(
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}');
      } else {
        canResendCode(true);
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> reSendCode() async {
    canResendCode(false);

    if (_otpParam != null) {
      final response =
          await _authService.resenCodeToChangePassword(email: _otpParam.email);
      if (response) {
        startTimer();
        showSuccess(message: 'Código enviado com sucesso');
      }
    }

    final response = await _repository.refreshCode(
      RefreshCodeRequest(code: code),
    );
    if (response.success && response.result != null) {
      final newCode = response.result!.code;
      code = newCode;
      startTimer();
      showSuccess(message: 'Código enviado com sucesso');
      return;
    }
    showError(message: response.errorMessages?.first);
  }

  String get pinCombination =>
      pin1.text + pin2.text + pin3.text + pin4.text + pin5.text + pin6.text;

  bool loadingActiveAccount = false;

  bool forwardScreenHome = false;

  Future<void> next() async => _otpParam != null && _otpParam.isChanging
      ? await goToChangePassword()
      : await activeAccount();

  Future<void> activeAccount() async {
    isLoading(true);
    final response = await _repository.activeAccount(
      ActiveAccountRequest(code: pinCombination, token: code),
    );
    if (!response.success) {
      showError(message: response.errorMessages?.first ?? 'Algo deu errado');
      return;
    }

    await _authService.makeLogin(response.result!);

    final havePet = await _checkHavePet();

    _navigationService
        .offNamed(havePet ? HomeRoutes.home : NewPetRoutes.newPet);

    //await _navigationService.offAllNamed(SplashRoutes.splash);
    isLoading(false);
    showSuccess(message: 'Conta ativada com sucesso');
  }

  Future<bool> _checkHavePet() async {
    final response = await _homeRepository.getPets();
    if (response.result != null) {
      return response.result!.isNotEmpty;
    }
    return false;
  }

  Future<void> goToChangePassword() async {
    _navigationService.toNamed(NewPasswordRoutes.newPassword,
        arguments: pinCombination);
  }
}
