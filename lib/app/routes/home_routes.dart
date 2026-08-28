import 'package:get/get.dart';
import 'package:idee_pet/app/modules/home/modules/profile/profile_binding.dart';
import 'package:idee_pet/app/modules/home/modules/profile/profile_page.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';

class HomeRoutes {
  HomeRoutes._();

  static const home = '/home';
  static const profile = '/home/profile';

  static final routes = [
    GetPage(
      name: home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
  ];
}
