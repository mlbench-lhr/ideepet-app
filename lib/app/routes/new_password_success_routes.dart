import 'package:get/get.dart';

import '../modules/new_password_success/new_password_success_binding.dart';
import '../modules/new_password_success/new_password_success_page.dart';

sealed class NewPasswordSuccessRoutes {
  static const newPasswordSuccess = '/new-password-success';

  static final routes = [
    GetPage(
      name: newPasswordSuccess,
      page: () => const NewPasswordSuccessPage(),
      binding: NewPasswordSuccessBinding(),
    ),
  ];
}
