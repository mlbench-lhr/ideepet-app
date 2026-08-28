import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/modules/transfer_pet/enums/flow_step.dart';
import 'package:idee_pet/app/modules/transfer_pet/pages/error_page.dart';
import 'package:idee_pet/app/modules/transfer_pet/pages/initial_page.dart';
import 'package:idee_pet/app/modules/transfer_pet/pages/sucess_page.dart';
import 'package:idee_pet/app/modules/transfer_pet/transfer_pet_controller.dart';

class TransferPetPage extends GetView<TransferPetController> {
  const TransferPetPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.step.value) {
        case TransferPetFlow.initial:
          return InitialPage();
        case TransferPetFlow.error:
          return ErrorPage();
        case TransferPetFlow.success:
          return SucessPage();
        // case TransferPetFlow.confirmed:
        //   return ConfirmedPage();
        default:
          return Container();
      }
    });
  }
}
