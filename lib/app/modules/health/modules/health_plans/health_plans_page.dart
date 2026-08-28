import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

import 'package:skeletonizer/skeletonizer.dart';

class HealthPlansPage extends BasePage<HealthPlansController> {
  const HealthPlansPage({super.key});

  @override
  Widget body(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HealthHeader(
            pet: controller.appStateService.pet(),
          ),
          SizedBox(height: 10),
          Text(
            'Plano de saúde',
            style: AppTextStyles.title(fontSize: 24).style,
          ),
          SizedBox(height: 10),
          Expanded(
            child: Obx(
              () => controller.isLoading.isTrue
                  ? ListLoading()
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.healthPlans.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final healthPlan = controller.healthPlans[index];
                        return HealthPlansListItemTile(
                          text: healthPlan.name,
                          isSelected: healthPlan.isSelected ||
                              controller.appStateService.pet().healthPlanId ==
                                  healthPlan.id,
                          onTap: () {
                            controller.setSelectedPlan(healthPlan);
                            controller.back();
                          },
                        );
                      },
                    ),
            ),
          ),
          SizedBox(height: 100),
        ],
      );
}
