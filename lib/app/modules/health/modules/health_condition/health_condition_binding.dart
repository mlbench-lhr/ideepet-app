import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class HealthConditionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthConditionRepository>(() => HealthConditionRepository());
    Get.lazyPut<HealthConditionController>(
      () => HealthConditionController(
        Get.find(),
        Get.find(),
      ),
    );
  }
}
