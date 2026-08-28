import 'package:get/get.dart';
import 'package:idee_pet/app/modules/new_pet/new_pet_controller.dart';
import 'package:idee_pet/app/modules/new_pet/repository/new_pet_repository.dart';

class NewPetBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => NewPetRepository())
      ..lazyPut<NewPetController>(
        () => NewPetController(
          Get.find(),
          Get.find(),
          Get.find(),
        ),
      );
  }
}
