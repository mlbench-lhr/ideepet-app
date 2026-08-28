import 'package:get/get.dart';
import 'package:idee_pet/app/modules/new_pet/new_pet_binding.dart';
import 'package:idee_pet/app/modules/new_pet/new_pet_page.dart';
import 'package:idee_pet/app/modules/transfer_pet/transfer_pet_binding.dart';
import 'package:idee_pet/app/modules/transfer_pet/transfer_pet_page.dart';

class TransferPetRoutes {
  TransferPetRoutes._();

  static const transferPet = '/transfer_pet';

  static final routes = [
    GetPage(
      name: transferPet,
      page: () => TransferPetPage(),
      binding: TransferPetBinding(),
    ),
  ];
}
