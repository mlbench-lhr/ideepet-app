import 'package:get/get.dart';
import 'package:idee_pet/app/modules/transfer_pet/repository/transfer_pet_repository.dart';
import 'package:idee_pet/app/modules/transfer_pet/transfer_pet_controller.dart';

class TransferPetBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<TransferPetRepository>(TransferPetRepository.new)
      ..lazyPut(() => TransferPetController(
            Get.find(),
          ));
  }
}
