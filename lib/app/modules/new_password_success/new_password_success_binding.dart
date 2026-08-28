import 'package:get/get.dart';

import 'new_password_success_controller.dart';

class NewPasswordSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPasswordSuccessController>(
      () => NewPasswordSuccessController(Get.find()),
    );
  }
}
