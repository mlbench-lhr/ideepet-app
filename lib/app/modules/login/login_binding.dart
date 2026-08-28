import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
  }
}
