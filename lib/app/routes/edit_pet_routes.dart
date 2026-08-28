import 'package:get/get.dart';
import 'package:idee_pet/app/modules/edit_pet/edit_pet_binding.dart';
import 'package:idee_pet/app/modules/edit_pet/modules/details/edit_details_page.dart';
import 'package:idee_pet/app/modules/edit_pet/modules/food/edit_food_page.dart';
import 'package:idee_pet/app/modules/edit_pet/modules/personality/edit_personality_page.dart';
import 'package:idee_pet/app/modules/edit_pet/modules/size/edit_size_page.dart';

class EditPetRoutes {
  EditPetRoutes._();

  static const editFood = '/edit_food';
  static const editPersonality = '/edit_personality';
  static const editDetails = '/edit_details';
  static const editSize = '/edit_size';

  static final routes = [
    GetPage(
      name: editFood,
      page: () => EditFoodPage(),
      binding: EditPetBinding(),
    ),
    GetPage(
      name: editPersonality,
      page: () => EditPersonalityPage(),
      binding: EditPetBinding(),
    ),
    GetPage(
      name: editDetails,
      page: () => EditDetailsPage(),
      binding: EditPetBinding(),
    ),
    GetPage(
      name: editSize,
      page: () => EditSizePage(),
      binding: EditPetBinding(),
    ),
  ];
}
