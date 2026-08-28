import 'package:get/get.dart';
import 'package:idee_pet/app/modules/biometrics/repository/biometrics_repository.dart';

import 'biometric_controller.dart';

class BiometricBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<BiometricsRepository>(BiometricsRepository())
      ..put<BiometricController>(
        BiometricController(Get.find(), Get.find()),
      );
  }
}
