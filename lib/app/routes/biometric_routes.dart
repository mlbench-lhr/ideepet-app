import 'package:get/get.dart';
import 'package:idee_pet/app/modules/biometric/biometric_binding.dart';
import 'package:idee_pet/app/modules/biometric/biometric_page.dart';
import 'package:idee_pet/app/modules/biometric/resend_page.dart';
import 'package:idee_pet/app/modules/edit_pet/modules/image/edit_image_page.dart';

class BiometricRoutes {
  BiometricRoutes._();

  static const biometric = '/biometric';
  static const resend = '/resend';
  static const image = '/image';

  static final routes = [
    GetPage(
      name: biometric,
      page: () => const BiometricPage(),
      binding: BiometricBinding(),
    ),
    GetPage(
      name: resend,
      page: () => const ResendPage(),
      binding: BiometricBinding(),
    ),
    GetPage(
      name: image,
      page: () => const EditImagePage(),
      binding: BiometricBinding(),
    ),
  ];
}
