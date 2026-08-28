import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VaccinePage extends BasePage<VaccineController> {
  VaccinePage({super.key});

  @override
  Widget body(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HealthHeader(pet: controller.appStateService.pet()),
          SizedBox(height: 10),
          Text(
            'Histórico de vacinas',
            style: AppTextStyles.title(fontSize: 24).style,
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () => showAddVaccineDialog(
              context,
              controller.appStateService.pet(),
              controller.loadingCreateVaccine(),
              controller.createVaccine,
            ),
            borderRadius: BorderRadius.circular(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: AppColors.selectYellow,
                ),
                Text(
                  'Adicionar vacina',
                  style: AppTextStyles.poppinsMedium(
                    fontSize: 12.45,
                    color: AppColors.selectYellow,
                  ).style,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              final upcomingVaccines = controller.vaccines
                  .where((vaccine) =>
                      vaccine.reforce?.isAfter(DateTime.now()) ?? false)
                  .toList();

              final allVaccines = controller.vaccines;

              return Skeletonizer(
                enabled: controller.isLoading(),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: controller.isLoading()
                      ? 7
                      : allVaccines.length + upcomingVaccines.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (controller.isLoading()) {
                      return VaccineCardEmpty(vaccine: VaccineResponse.empty());
                    }

                    // Exibir os reforços primeiro
                    if (index < upcomingVaccines.length) {
                      return ReforceCardVaccine(
                        vaccine: upcomingVaccines[index],
                      );
                    }

                    // Exibir as vacinas gerais
                    final vaccineIndex = index - upcomingVaccines.length;
                    return VaccineCard(
                      edit: controller.editVaccine,
                      loading: controller.loadingCreateVaccine(),
                      pet: controller.appStateService.pet(),
                      vaccine: allVaccines[vaccineIndex],
                      delete: controller.deleteVaccine,
                    );
                  },
                ),
              );
            }),
          ),
          SizedBox(height: 100),
        ],
      );
}
