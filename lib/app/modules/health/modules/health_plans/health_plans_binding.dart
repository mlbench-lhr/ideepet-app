import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class HealthPlansBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => HealthPlansRepository())
      ..lazyPut<HealthPlansController>(
        () => HealthPlansController(
          Get.find(),
          Get.find(),
          Get.find(),
        ),
      );
  }
}
