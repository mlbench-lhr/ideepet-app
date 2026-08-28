import 'package:get/get.dart';

import '../modules/new_password/new_password_binding.dart';
import '../modules/new_password/new_password_page.dart';

sealed class NewPasswordRoutes {
  static const newPassword = '/new-password';

  static final routes = [
    GetPage(
      name: newPassword,
      page: () => const NewPasswordPage(),
      binding: NewPasswordBinding(),
    ),
  ];
}
