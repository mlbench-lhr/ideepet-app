import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<HomeRepository>(HomeRepository.new)
      ..lazyPut<SplashController>(
        () => SplashController(
          Get.find(),
          Get.find(),
          Get.find(),
        ),
      );
  }
}
