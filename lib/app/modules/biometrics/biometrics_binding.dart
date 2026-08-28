import 'package:get/get.dart';

import 'package:idee_pet/lib.dart';

class BiometricsBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<BiometricsRepository>(BiometricsRepository())
      ..put<BiometricsController>(
        BiometricsController(
          Get.find(),
          Get.find(),
          Get.find(),
        ),
      );
  }
}
