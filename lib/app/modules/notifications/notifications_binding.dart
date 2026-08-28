import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<NotificationsRepository>(() => NotificationsRepository())
      ..lazyPut<NotificationsController>(
        () => NotificationsController(
          Get.find(),
          Get.find(),
        ),
      );
  }
}
