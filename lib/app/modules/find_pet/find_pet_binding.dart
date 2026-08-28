import 'package:get/get.dart';

import 'find_pet_controller.dart';

class FindPetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindPetController>(
      () => FindPetController(Get.find()),
    );
  }
}
