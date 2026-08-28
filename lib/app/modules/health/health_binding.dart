import 'package:get/get.dart';

import 'health_controller.dart';

class HealthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthController>(
      () => HealthController(
        Get.find(),
        Get.find(),
      ),
    );
  }
}
