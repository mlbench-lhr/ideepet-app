import 'package:get/get.dart';
import 'package:idee_pet/app/modules/home/modules/profile/repository/profile_repository.dart';

import 'profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<ProfileRepository>(() => ProfileRepository())
      ..lazyPut<ProfileController>(
        () => ProfileController(
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
        ),
      );
  }
}
