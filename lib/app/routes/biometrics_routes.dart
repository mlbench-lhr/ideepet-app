import 'package:get/get.dart';
import 'package:idee_pet/app/modules/biometrics/biometrics_binding.dart';
import 'package:idee_pet/app/modules/biometrics/biometrics_page.dart';

class BiometricsRoutes {
  BiometricsRoutes._();

  static const biometrics = '/biometrics';

  static final routes = [
    GetPage(
      name: biometrics,
      page: () => const BiometricsPage(),
      binding: BiometricsBinding(),
    ),
  ];
}
