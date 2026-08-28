import 'package:get/get.dart';
import 'package:idee_pet/lib.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<HomeRepository>(HomeRepository.new)
      ..lazyPut<OtpRepository>(OtpRepository.new)
      ..lazyPut<OtpController>(
        () => OtpController(
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
        ),
      );
  }
}
