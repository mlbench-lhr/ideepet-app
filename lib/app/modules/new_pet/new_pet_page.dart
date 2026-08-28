import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:idee_pet/app/modules/new_pet/modules/first_pet/first_pet.dart';
import 'package:idee_pet/app/modules/new_pet/modules/step1/step1_page.dart';
import 'package:idee_pet/app/modules/new_pet/modules/step2/step2_page.dart';
import 'package:idee_pet/app/modules/new_pet/modules/step3/step3_page.dart';
import 'package:idee_pet/app/modules/new_pet/modules/step4/step4_page.dart';
import 'package:idee_pet/app/modules/new_pet/modules/step5/step5_page.dart';
import 'package:idee_pet/app/modules/new_pet/modules/step6/step6_page.dart';
import 'package:idee_pet/app/modules/new_pet/new_pet_controller.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/dialogs.dart';

class NewPetPage extends GetView<NewPetController> {
  NewPetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (!didPop) {
              if (controller.pageController.page == 0) {
                if (controller.appStateService.pets.isEmpty) {
                  DialogApp.showOkCancelDialog(
                    context,
                    'Deseja sair do Idee Pet?',
                    'Se você sair, perderá todas as informações inseridas.',
                    () {
                      Get.back();
                    },
                  );
                } else {
                  controller.goToHome();
                }
              } else {
                controller.previosPage();
              }
            }
          },
          child: Padding(
            padding: controller.appStateService.pets.isEmpty &&
                    controller.currentPage() == 0
                ? EdgeInsets.zero
                : EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 30),
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              onPageChanged: controller.setCurrentPage,
              children: [
                if (controller.appStateService.pets.isEmpty) FirstPet(),
                NewPetStep1Page(),
                Step2Page(),
                NewPetStep3Page(),
                NewPetStep4Page(),
                NewPetStep5Page(),
                NewPetStep6Page(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
