import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/core/base/base_page.dart';
import 'package:idee_pet/app/modules/health/modules/medicament/medicament_controller.dart';
import 'package:idee_pet/app/modules/health/modules/medicament/repository/dtos/response/medicament_response.dart';
import 'package:idee_pet/app/modules/health/modules/medicament/widgets/dialog_add_medicament.dart';
import 'package:idee_pet/app/modules/health/modules/medicament/widgets/medicament_card_list.dart';
import 'package:idee_pet/app/modules/health/modules/medicament/widgets/reforce_card_medicament.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MedicamentPage extends BasePage<MedicamentController> {
  MedicamentPage({super.key});

  @override
  Widget body(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Navigator.pop(context);
                },
              ),
              // CircularImageWidget(
              //   imageUrl: widget.pet.avatarUrl,
              //   borderColor: AppColors.buttonColor2,
              // )
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Histórico de medicamentos',
            style: AppTextStyles.title(fontSize: 24).style,
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () => showAddMedicamentDialog(
              context,
              controller.appStateService.pet(),
              controller.loadingCreateMedicament(),
              controller.createMedicament,
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
                  'Adicionar medicamento',
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
              final upcomingMedicaments = controller.medicaments
                  .where((medicaments) =>
                      medicaments.reforce?.isAfter(DateTime.now()) ?? false)
                  .toList();

              final allMedicaments = controller.medicaments;

              return Skeletonizer(
                enabled: controller.isLoading(),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: controller.isLoading()
                      ? 7
                      : allMedicaments.length + upcomingMedicaments.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (controller.isLoading()) {
                      return MedicamentCardListEmpty(
                          medicament: MedicamentResponse.empty());
                    }

                    // Exibir os reforços primeiro
                    if (index < upcomingMedicaments.length) {
                      return ReforceCardMedicament(
                        medicament: upcomingMedicaments[index],
                      );
                    }

                    final medicamentIndex = index - upcomingMedicaments.length;
                    return MedicamentCardList(
                      medicament: allMedicaments[medicamentIndex],
                      delete: controller.deleteMedicament,
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
