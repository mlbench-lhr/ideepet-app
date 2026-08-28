import 'package:get/get.dart';

import '../modules/otp/otp_binding.dart';
import '../modules/otp/otp_page.dart';

sealed class OtpRoutes {
  static const otp = '/otp';

  static final routes = [
    GetPage(
      name: otp,
      page: () => const OtpPage(),
      binding: OtpBinding(),
    ),
  ];
}
