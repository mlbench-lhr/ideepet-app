import 'package:get/get.dart';
import 'package:idee_pet/app/modules/find_pet_result/find_pet_result_binding.dart';
import 'package:idee_pet/app/modules/find_pet_result/find_pet_result_page.dart';

sealed class FindPetResultRoutes {
  static const findPetResult = '/find-pet-result';

  static final routes = [
    GetPage(
      name: findPetResult,
      page: () => const FindPetResultPage(),
      binding: FindPetResultBinding(),
    ),
  ];
}
