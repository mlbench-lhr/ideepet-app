import 'package:get/get.dart';
import 'package:idee_pet/app/modules/biometrics/modules/capture_image/capture_image_binding.dart';
import 'package:idee_pet/app/modules/biometrics/modules/capture_image/capture_image_page.dart';

class CaptureImageRoutes {
  CaptureImageRoutes._();
  static const captureImage = '/capture_image';

  static final routes = [
    GetPage(
      name: captureImage,
      page: () => CaptureImagePage(),
      binding: CaptureImageBinding(),
    ),
  ];
}
