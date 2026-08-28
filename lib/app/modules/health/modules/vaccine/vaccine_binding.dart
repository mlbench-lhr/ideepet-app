import 'package:get/get.dart';
import 'package:idee_pet/app/modules/health/modules/vaccine/repository/vaccine_repository.dart';
import 'package:idee_pet/app/modules/health/modules/vaccine/vaccine_controller.dart';

class VaccineBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => VaccineRepository())
      ..lazyPut<VaccineController>(
        () => VaccineController(
          Get.find(),
          Get.find(),
        ),
      );
  }
}
