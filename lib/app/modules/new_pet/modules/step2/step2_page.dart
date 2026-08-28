import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/modules/new_pet/new_pet_controller.dart';

import 'package:skeletonizer/skeletonizer.dart';

class Step2Page extends GetView<NewPetController> {
  const Step2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                    icon: CircleAvatar(
                      backgroundColor: AppColors.greyWhite,
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.primary,
                      ),
                    ),
                    onPressed: () {
                      controller.previosPage();
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Conte-nos mais\nsobre o seu pet',
                    style: AppTextStyles.title(fontSize: 28).style,
                  ),
                  SizedBox(height: 36),
                  Obx(
                    () {
                      return AppTextField(
                        onTapOutside: () => FocusScope.of(context).nextFocus(),
                        controller: controller.petNameController,
                        textInputAction: TextInputAction.next,
                        bordercolor: Colors.transparent,
                        cursorColor: AppColors.primary,
                        hintText: 'Nome',
                        maxLines: 1,
                        erroText: controller.petNameError(),
                        onChanged: (_) => controller.validatePetNameField(),
                      );
                    },
                  ),
                  SizedBox(height: 18),
                  Obx(
                    () {
                      return BottomSheetSelector(
                        onSelected: controller.selectWeight,
                        items: controller.listWeights,
                        title: 'Peso aproximado',
                        displayText: (weight) => weight.label,
                        selected: controller.selectedWeight(),
                      );
                    },
                  ),
                  SizedBox(height: 18),
                  Obx(
                    () {
                      return AppTextField(
                        keyboardType: TextInputType.number,
                        onTapOutside: () => FocusScope.of(context).nextFocus(),
                        controller: controller.dateOfBirthController,
                        textInputAction: TextInputAction.next,
                        bordercolor: Colors.transparent,
                        cursorColor: AppColors.primary,
                        hintText: 'Data de nascimento',
                        maxLines: 1,
                        erroText: controller.dateOfBirthError(),
                        onChanged: (_) => controller.validateDateOfBirthField(),
                        inputFormatters: [DateInputFormatter()],
                      );
                    },
                  ),
                  SizedBox(height: 18),
                  Obx(
                    () {
                      return Skeletonizer(
                        enabled: controller.loadingBreeds(),
                        child: BottomSheetSelector(
                          onSelected: controller.selectBreed,
                          items: controller.breeds,
                          title: 'Raças',
                          selected: controller.selectedBreed(),
                          displayText: (breed) => breed.name,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 18),
                  Obx(
                    () {
                      return BottomSheetSelector(
                        onSelected: controller.selectSex,
                        items: PetSex.values,
                        title: 'Sexo',
                        selected: controller.selectedSex(),
                        displayText: (sex) => sex.label,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(
          () {
            return CustomButton.filled(
              action: controller.detailsComplete
                  ? () {
                      controller.nextPage(context);
                    }
                  : null,
              title: Text(
                'Continuar',
                style: AppTextStyles.poppinsSemiBold(
                  color: AppColors.background,
                ).style,
              ),
            );
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
