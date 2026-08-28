import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/modules/new_pet/new_pet_controller.dart';

class NewPetStep4Page extends GetView<NewPetController> {
  const NewPetStep4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
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
                  'Qual tipo de comida o seu\npet costuma consumir?',
                  style: AppTextStyles.title(fontSize: 20).style,
                ),
                SizedBox(height: 36),
                Obx(() {
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) => SizedBox(height: 18),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.foodOptions.length,
                    itemBuilder: (context, index) {
                      final food = controller.foodOptions[index];

                      return Obx(
                        () {
                          final isSelected = controller.containsString(
                              controller.selectedFoods, food);

                          return CustomButtonSelect(
                            title: Row(
                              children: [
                                Text(
                                  food,
                                  style: AppTextStyles.poppinsSemiBold(
                                    color: isSelected
                                        ? AppColors.background
                                        : AppColors.primary,
                                  ).style,
                                ),
                              ],
                            ),
                            select: isSelected,
                            action: () {
                              if (isSelected) {
                                controller.removeFoodInList(food);
                              } else {
                                controller.addFoodInList(food);
                              }
                            },
                          );
                        },
                      );
                    },
                  );
                }),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () {
                          return AppTextField(
                            controller: controller.petFoodController,
                            textInputAction: TextInputAction.done,
                            bordercolor: Colors.transparent,
                            cursorColor: AppColors.primary,
                            hintText: 'Outro',
                            maxLines: 1,
                            erroText: controller.petFoodError(),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.add, color: AppColors.primary),
                      onPressed: () {
                        controller.addCustomFood();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Obx(
          () {
            return CustomButton.filled(
              action: controller.foodComplete
                  ? () => controller.nextPage(context)
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
