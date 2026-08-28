import 'package:get/get.dart';
import 'package:idee_pet/app/modules/edit_pet/edit_pet_controller.dart';
import 'package:idee_pet/app/modules/edit_pet/repository/edit_pet_repository.dart';

class EditPetBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => EditPetRepository())
      ..lazyPut<EditPetController>(
        () => EditPetController(
          Get.find(),
          Get.find(),
          // Get.find(),
        ),
      );
  }
}
