import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/modules/new_pet/modules/step5/components/health_condition_component.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/widgets.dart';

import '../../new_pet_controller.dart';

class NewPetStep5Page extends GetView<NewPetController> {
  const NewPetStep5Page({super.key});

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
                  'Vamos falar sobre a\nsaúde do seu pet',
                  style: AppTextStyles.title(fontSize: 24).style,
                ),
                SizedBox(height: 36),
                Text(
                  'Seu pet possui plano de saúde?',
                  style: AppTextStyles.poppinsMedium(
                          color: AppColors.fontColorSubtitle, fontSize: 18)
                      .style,
                ),
                SizedBox(height: 16),
                Obx(
                  () {
                    return Row(
                      children: [
                        Flexible(
                          child: CustomButtonSelect(
                            title: Text(
                              'Sim',
                              style: AppTextStyles.poppinsSemiBold(
                                color: controller.healthPlan() == true
                                    ? AppColors.background
                                    : AppColors.primary,
                              ).style,
                            ),
                            select: controller.healthPlan() == true,
                            action: () {
                              controller.setHealthPlan(true);
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Flexible(
                          child: CustomButtonSelect(
                            title: Text(
                              'Não',
                              style: AppTextStyles.poppinsSemiBold(
                                color: controller.healthPlan() == false
                                    ? AppColors.background
                                    : AppColors.primary,
                              ).style,
                            ),
                            select: controller.healthPlan() == false,
                            action: () {
                              controller.setHealthPlan(false);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Obx(
                  () => controller.healthPlan() == true
                      ? Column(
                          children: [
                            SizedBox(height: 16),
                            BottomSheetSelector(
                              onSelected: controller.setSelectedHealthPlan,
                              items: controller.healthPlans(),
                              title: 'Plano',
                              displayText: (plan) => plan.name,
                              selected: controller.selectedHealthPlan(),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ),
                SizedBox(height: 16),
                Text(
                  'Seu pet possui alguma condição\nde saúde?',
                  style: AppTextStyles.poppinsMedium(
                          color: AppColors.fontColorSubtitle, fontSize: 18)
                      .style,
                ),
                SizedBox(height: 16),
                Obx(
                  () {
                    return Row(
                      children: [
                        Flexible(
                          child: CustomButtonSelect(
                            title: Text(
                              'Sim',
                              style: AppTextStyles.poppinsSemiBold(
                                color: controller.healthCondition() == true
                                    ? AppColors.background
                                    : AppColors.primary,
                              ).style,
                            ),
                            select: controller.healthCondition() == true,
                            action: () {
                              controller.setHealthCondition(true);
                              controller.validatePetConditionField();
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Flexible(
                          child: CustomButtonSelect(
                            title: Text(
                              'Não',
                              style: AppTextStyles.poppinsSemiBold(
                                color: controller.healthCondition() == false
                                    ? AppColors.background
                                    : AppColors.primary,
                              ).style,
                            ),
                            select: controller.healthCondition() == false,
                            action: () {
                              controller.setHealthCondition(false);
                              controller.validatePetConditionField();
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 16),
                Obx(
                  () => controller.healthCondition() == true
                      ? Column(
                          children: [
                            HealthConditionComponent(
                              textEditingController:
                                  controller.petConditionController,
                              healthConditionName:
                                  controller.healthConditionName(),
                              changeConditionText: (value) =>
                                  controller.setHealthConditionText(value),
                              changeDateCondition: (value) =>
                                  controller.setDate(value),
                              changeSeverity: (value) =>
                                  controller.setSeverity(value),
                              selectedSeverity: controller.selectedSeverity(),
                              selectedDate: controller.selectedDate(),
                              severityList: controller.severityList,
                            ),
                            SizedBox(height: 16),
                          ],
                        )
                      : SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
        Center(
          child: controller.selectedType() == PetType.dog
              ? CustomLogo.dogOnboarding()
              : CustomLogo.catOnboarding(),
        ),
        SizedBox(height: 10),
        Obx(
          () {
            return CustomButton.filled(
              action: controller.healthComplete()
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
