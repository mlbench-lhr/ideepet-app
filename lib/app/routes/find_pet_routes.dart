import 'package:get/get.dart';
import 'package:idee_pet/app/modules/find_pet/find_pet_binding.dart';
// import 'package:idee_pet/app/modules/find_pet/find_pet_page.dart';
import 'package:idee_pet/app/modules/find_pet/find_pet_screen.dart';

sealed class FindPetRoutes {
  static const findPet = '/find-pet';

  static final routes = [
    GetPage(
      name: findPet,
      // page: () => const FindPetPage(),
      page: () => const PetFindScanning(),
      binding: FindPetBinding(),
    ),
  ];
}
