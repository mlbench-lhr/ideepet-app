import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
  }
}
