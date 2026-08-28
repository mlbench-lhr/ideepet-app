import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/modules/new_pet/new_pet_controller.dart';

class NewPetStep1Page extends GetView<NewPetController> {
  const NewPetStep1Page({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.appStateService.pets.isNotEmpty)
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
                    controller.close();
                  },
                ),
              SizedBox(height: 10),
              Text(
                'Que tipo de pet você\ndeseja cadastrar?',
                style: AppTextStyles.title(fontSize: 28).style,
              ),
              SizedBox(height: 36),
              Obx(
                () {
                  return CustomButtonSelect(
                    title: Row(
                      children: [
                        Text(
                          'Cachorro',
                          style: AppTextStyles.poppinsSemiBold(
                            color: controller.selectedType() == PetType.dog
                                ? AppColors.background
                                : AppColors.primary,
                          ).style,
                        ),
                      ],
                    ),
                    select: controller.selectedType() == PetType.dog,
                    action: () => controller.selectType(PetType.dog),
                  );
                },
              ),
              SizedBox(height: 18),
              Obx(
                () {
                  return CustomButtonSelect(
                    title: Row(
                      children: [
                        Text(
                          'Gato',
                          style: AppTextStyles.poppinsSemiBold(
                            color: controller.selectedType() == PetType.cat
                                ? AppColors.background
                                : AppColors.primary,
                          ).style,
                        ),
                      ],
                    ),
                    select: controller.selectedType() == PetType.cat,
                    action: () => controller.selectType(PetType.cat),
                  );
                },
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: CustomLogo.dogCatOnboarding()),
              ),
            ],
          ),
        ),
        Obx(
          () {
            return CustomButton.filled(
              action: controller.selectedType() != PetType.none
                  ? () {
                      controller.getBreedNow();
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
