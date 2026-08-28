import 'package:get/get.dart';
import 'package:idee_pet/app/modules/find_pet_result/repository/find_pet_result_repository.dart';

import 'find_pet_result_controller.dart';

class FindPetResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindPetResultRepository>(() => FindPetResultRepository());
    Get.lazyPut<FindPetResultController>(
      () => FindPetResultController(Get.find(), Get.find()),
    );
  }
}
