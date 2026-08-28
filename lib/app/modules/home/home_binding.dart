import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<HomeRepository>(() => HomeRepository(), fenix: true)
      ..lazyPut<HomeController>(
        () => HomeController(
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
        ),
      );
  }
}
