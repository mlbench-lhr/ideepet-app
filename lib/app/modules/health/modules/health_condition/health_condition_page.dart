import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class HealthConditionPage extends BasePage<HealthConditionController> {
  const HealthConditionPage({super.key});

  @override
  Widget body(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HealthHeader(
              pet: controller.appStateService.pet(),
            ),
            SizedBox(height: 10),
            Text(
              'Condição de saúde',
              style: AppTextStyles.title(fontSize: 24).style,
            ),
            SizedBox(height: 24),
            Column(
              children: [
                AppTextField(
                  controller: controller.conditionTextController(),
                  keyboardType: TextInputType.text,
                  onChanged: (_) => controller.validate(),
                  textInputAction: TextInputAction.next,
                  bordercolor: Colors.transparent,
                  cursorColor: AppColors.primary,
                  labeltext: 'Condição de saúde',
                  hintText: 'Condição de saúde',
                  maxLines: 4,
                ),
                SizedBox(height: 24),
                Obx(() {
                  return AppDropdownSearch(
                    selectedItem: controller.selectedSeverity(),
                    hintText: 'Selecione a severidade',
                    items: controller.severityList(),
                    onChanged: (value) {
                      value != null
                          ? controller.setSeverity(value.toString())
                          : '';
                      controller.validate();
                    },
                  );
                }),
                SizedBox(height: 24),
                Obx(
                  () => controller.loadingDate.isTrue
                      ? Center(
                          child: LinearProgressIndicator(),
                        )
                      : DateSelectorWidget(
                          initialDate: controller.selectedDate(),
                          onDateSelected: controller.setDate,
                          hintText: 'Data do diagnóstico',
                        ),
                ),
                SizedBox(height: 100),
                Obx(() {
                  return CustomButton.filled(
                    action:
                        controller.canContinue.isTrue ? controller.save : null,
                    title: Text(
                      'Salvar',
                      style: AppTextStyles.poppinsSemiBold(
                        color: AppColors.background,
                      ).style,
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      );
}
