import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

import '../../new_pet_controller.dart';

class NewPetStep6Page extends GetView<NewPetController> {
  const NewPetStep6Page({super.key});

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
                  'Estamos quase prontos...',
                  style: AppTextStyles.title(fontSize: 24).style,
                ),
                Text(
                  'Como você  descreveria a personalidade\ndo seu pet?',
                  style: AppTextStyles.poppinsMedium(fontSize: 16).style,
                ),
                SizedBox(height: 36),
                ListView.separated(
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) => SizedBox(height: 18),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: PetPersonality.values.length,
                  itemBuilder: (context, index) {
                    final personality = PetPersonality.values[index];
                    return Obx(
                      () {
                        final isSelected = controller.selectedsPersonality
                            .contains(personality);

                        return CustomButtonSelect(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          title: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    personality.title,
                                    style: AppTextStyles.poppinsMedium(
                                      fontSize: 16,
                                      color: isSelected
                                          ? AppColors.background
                                          : AppColors.primary,
                                    ).style,
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    personality.subtitle,
                                    style: AppTextStyles.poppinsMedium(
                                      fontSize: 12,
                                      color: isSelected
                                          ? AppColors.background
                                          : AppColors.fontColorSubtitle,
                                    ).style,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          select: isSelected,
                          action: () {
                            if (isSelected) {
                              controller.removePersonalityInList(personality);
                            } else {
                              controller.addPersonalityInList(personality);
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Obx(
          () {
            return controller.isLoading.isTrue
                ? Center(
                    child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ))
                : CustomButton.filled(
                    action: controller.selectedsPersonality.isNotEmpty
                        ? () => controller.createPet()
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
