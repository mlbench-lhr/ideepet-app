import 'package:get/get.dart';
import 'package:idee_pet/app/modules/new_pet/new_pet_binding.dart';
import 'package:idee_pet/app/modules/new_pet/new_pet_page.dart';

class NewPetRoutes {
  NewPetRoutes._();

  static const newPet = '/new_pet';

  static final routes = [
    GetPage(
      name: newPet,
      page: () => NewPetPage(),
      binding: NewPetBinding(),
    ),
  ];
}
