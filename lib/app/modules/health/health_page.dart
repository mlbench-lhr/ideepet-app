import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class HealthPage extends BasePage<HealthController> {
  HealthPage({super.key});

  @override
  Widget body(BuildContext context) => Obx(
        () => controller.isLoading.isTrue
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Área de saúde',
                          style: AppTextStyles.title(fontSize: 18).style),
                      CircularImageWidget(
                          imageUrl: controller.appStateService.pet().avatarUrl),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CardHealth(
                      pet: controller.appStateService.pet(),
                      address:
                          controller.appStateService.profile().addressStreet),
                  const SizedBox(height: 10),
                  ButtonHealth(
                    svgPath: 'assets/health/syringe.svg',
                    title: 'Histórico de vacinas',
                    action: controller.goToVaccines,
                  ),
                  const SizedBox(height: 10),
                  ButtonHealth(
                    svgPath: 'assets/health/drog.svg',
                    title: 'Medicamentos',
                    action: controller.goToMedicaments,
                  ),
                  const SizedBox(height: 10),
                  ButtonHealth(
                    svgPath: 'assets/health/hospital.svg',
                    title: 'Prontuário',
                    action: controller.goToMedicalRecors,
                  ),
                  const SizedBox(height: 10),
                  ButtonHealth(
                    svgPath: 'assets/health/plan_health.svg',
                    title: 'Plano de saúde',
                    action: controller.goToPlans,
                  ),
                  const SizedBox(height: 10),
                  ButtonHealth(
                    svgPath: 'assets/health/book.svg',
                    title: 'Condição de saúde',
                    action: controller.goToCondition,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
      );
}
