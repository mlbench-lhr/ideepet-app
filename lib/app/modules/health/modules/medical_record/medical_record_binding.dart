import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class MedicalRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<MedicalRecordRepository>(MedicalRecordRepository.new)
      ..lazyPut<MedicalRecordController>(
        () => MedicalRecordController(
          Get.find(),
          Get.find(),
          Get.find(),
        ),
      );
  }
}
