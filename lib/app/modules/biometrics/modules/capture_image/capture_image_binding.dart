import 'package:get/get.dart';
import 'package:idee_pet/app/modules/biometrics/modules/capture_image/capture_image_controller.dart';

class CaptureImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CaptureImageController>(CaptureImageController());
  }
}
