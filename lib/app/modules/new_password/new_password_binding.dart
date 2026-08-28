import 'package:get/get.dart';
import 'package:idee_pet/app/modules/new_password/repository/new_password_repository.dart';

import 'new_password_controller.dart';

class NewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<NewPasswordRepository>(NewPasswordRepository.new)
      ..lazyPut<NewPasswordController>(
        () => NewPasswordController(
          Get.find(),
          Get.find(),
        ),
      );
  }
}
