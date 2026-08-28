import 'package:get/get.dart';
import 'package:idee_pet/lib.dart';

class OnboardingBindings implements Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<ViaCepRepository>(ViaCepRepository.new)
      ..lazyPut<ViaCepService>(() => ViaCepService(Get.find()))
      ..lazyPut<OnboardingRepository>(OnboardingRepository.new)
      ..lazyPut(
        () => OnboardingController(
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
        ),
      );
  }
}
