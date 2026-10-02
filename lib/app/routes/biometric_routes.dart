import 'package:get/get.dart';
import 'package:idee_pet/app/modules/biometric/biometic_scanning.dart';
import 'package:idee_pet/app/modules/biometric/biometric_binding.dart';
import 'package:idee_pet/app/modules/biometric/biometric_guide.dart';
import 'package:idee_pet/app/modules/biometric/biometric_page.dart';
import 'package:idee_pet/app/modules/biometric/biometric_pet_image.dart';
import 'package:idee_pet/app/modules/biometric/resend_page.dart';
import 'package:idee_pet/app/modules/edit_pet/modules/image/edit_image_page.dart';

class BiometricRoutes {
  BiometricRoutes._();

  static const biometric = '/biometric';
  static const resend = '/resend';
  static const image = '/image';
  static const guide = '/biometric-guide';
  static const scanning = '/biometric-scanning';
  static const petImage = '/biometric-pet-image';

  static final routes = [
    GetPage(
      name: petImage,
      page: () => const BiometricPetImagePage(),
      binding: BiometricBinding(),
    ),
    GetPage(
      name: guide,
      page: () => const BiometricGuide(),
    ),
    GetPage(
      name: scanning,
      page: () => const BiometicScanning(),
      binding: BiometricBinding(),
    ),
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
