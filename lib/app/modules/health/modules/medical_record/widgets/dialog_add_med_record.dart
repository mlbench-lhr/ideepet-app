import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

void showAddMedRecordDialog(
  BuildContext context,
  Pet pet,
  bool loading,
  Future<void> Function(CreateMedicalRecordRequest request) create,
) {
  final medRecord = TextEditingController();
  DateTime? date;
  final canProceed = false.obs;

  void _validate() {
    canProceed.value = medRecord.text.isNotEmpty && date != null;
  }

  void setDate(DateTime value) {
    date = value;
    _validate();
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.all(16),
        content: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
            _validate();
          },
          child: GetBuilder<MedicalRecordController>(
            builder: (controller) => Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Adicione novo prontuário",
                  style: AppTextStyles.poppinsSemiBold(
                    fontSize: 14,
                    color: AppColors.primary,
                  ).style,
                ),
                AppTextField(
                  bordercolor: Colors.transparent,
                  hintText: 'Descrição',
                  controller: medRecord,
                  onTapOutside: () => FocusScope.of(context).nextFocus(),
                  onChanged: (value) => _validate(),
                ),
                DateSelectorWidget(
                  initialDate: date,
                  onDateSelected: setDate,
                  hintText: 'Data',
                ),
                Center(
                  child: Obx(() => controller.isLoading.isTrue
                      ? LinearProgressIndicator()
                      : ElevatedButton(
                          onPressed: loading || canProceed.isFalse
                              ? null
                              : () async {
                                  await create(
                                    CreateMedicalRecordRequest(
                                      title: medRecord.text,
                                      petId: pet.id,
                                      date: date,
                                    ),
                                  );
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: AppColors.grey,
                            backgroundColor: AppColors.primary,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide.none,
                            ),
                            shadowColor: AppColors.primary.withAlpha(80),
                          ),
                          child: loading
                              ? SizedBox(
                                  width: 38,
                                  height: 38,
                                  child: CircularProgressIndicator(
                                      color: AppColors.background),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Adicionar',
                                      style: AppTextStyles.poppinsSemiBold(
                                        color: AppColors.background,
                                      ).style,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                        )),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
