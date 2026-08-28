import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class MedicalRecordPage extends BasePage<MedicalRecordController> {
  const MedicalRecordPage({super.key});

  @override
  Widget body(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HealthHeader(pet: controller.appStateService.pet()),
          SizedBox(height: 10),
          Text(
            'Prontuário',
            style: AppTextStyles.title(fontSize: 24).style,
          ),
          SizedBox(height: 20),
          Obx(
            () => controller.isLoading.isTrue
                ? LinearProgressIndicator()
                : InkWell(
                    onTap: () => showAddMedRecordDialog(
                      context,
                      controller.appStateService.pet(),
                      controller.isLoading(),
                      controller.createMedicalRecord,
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
                          'Adicionar prontuário',
                          style: AppTextStyles.poppinsMedium(
                            fontSize: 12.45,
                            color: AppColors.selectYellow,
                          ).style,
                        ),
                      ],
                    ),
                  ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Obx(
              () => controller.isLoading.isTrue
                  ? ListLoading()
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12),
                      itemCount: controller.list.length,
                      itemBuilder: (_, index) => MedicalRecordCard(
                        medRecord: controller.list[index],
                        delete: controller.deleteMedicalRecord,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 100),
        ],
      );
}
