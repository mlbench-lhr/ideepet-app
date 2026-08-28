import 'package:get/get.dart';

import '../modules/initial/initial_binding.dart';
import '../modules/initial/initial_page.dart';

class InitialRoutes {
  InitialRoutes._();

  static const initial = '/initial';

  static final routes = [
    GetPage(
      name: initial,
      page: () => const InitialPage(),
      binding: InitialBinding(),
    ),
  ];
}
