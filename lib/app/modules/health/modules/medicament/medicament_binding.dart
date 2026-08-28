import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class MedicamentBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => MedicamentRepository())
      ..lazyPut<MedicamentController>(
        () => MedicamentController(
          Get.find(),
          Get.find(),
        ),
      );
  }
}
