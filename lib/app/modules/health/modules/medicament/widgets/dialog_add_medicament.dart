import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

void showAddMedicamentDialog(
  BuildContext context,
  Pet pet,
  bool loading,
  Future<void> Function(CreateMedicamentRequest request) createMedicament,
) {
  final medicament = TextEditingController();
  final lote = TextEditingController();
  DateTime? date;
  DateTime? reforce;
  PetWeight? selectedWeight;
  final canProceed = false.obs;

  void setDate(DateTime value) {
    date = value;
  }

  void setReforce(DateTime value) {
    reforce = value;
  }

  void _validate() {
    canProceed.value = medicament.text.isNotEmpty &&
        lote.text.isNotEmpty &&
        selectedWeight != null &&
        date != null;
  }

  List<PetWeight> listWeights =
      pet.type == PetType.dog ? DogWeight.values : CatWeight.values;
  void selectWeight(PetWeight? weight) => selectedWeight = weight;

  showDialog(
    context: context,
    barrierDismissible: !loading,
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
          child: GetBuilder<MedicamentController>(
            builder: (controller) => Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Adicione novo medicamento",
                  style: AppTextStyles.poppinsSemiBold(
                    fontSize: 14,
                    color: AppColors.primary,
                  ).style,
                ),
                AppTextField(
                  bordercolor: Colors.transparent,
                  hintText: 'Medicamento',
                  controller: medicament,
                  onTapOutside: () => FocusScope.of(context).nextFocus(),
                  onChanged: (value) => _validate(),
                ),
                AppTextField(
                  bordercolor: Colors.transparent,
                  hintText: 'Lote',
                  controller: lote,
                  onTapOutside: () => FocusScope.of(context).nextFocus(),
                  onChanged: (value) => _validate(),
                ),
                BottomSheetSelector(
                  onSelected: (value) {
                    selectWeight(value);
                    _validate();
                  },
                  items: listWeights,
                  title: 'Peso do pet',
                  displayText: (weight) => weight.label,
                  selected: selectedWeight,
                ),
                Row(
                  spacing: 10,
                  children: [
                    Flexible(
                      child: DateSelectorWidget(
                        initialDate: date,
                        onDateSelected: (value) {
                          setDate(value);
                          _validate();
                        },
                        hintText: 'Data',
                      ),
                    ),
                    Flexible(
                      child: DateSelectorWidget(
                        initialDate: reforce,
                        onDateSelected: setReforce,
                        hintText: 'Reforço',
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Obx(() => controller.processingCreate.isTrue
                      ? LinearProgressIndicator()
                      : ElevatedButton(
                          onPressed: loading || canProceed.isFalse
                              ? null
                              : () async {
                                  await createMedicament(
                                    CreateMedicamentRequest(
                                      title: medicament.text,
                                      lote: lote.text,
                                      weight: selectedWeight?.value,
                                      petId: pet.id,
                                      date: date,
                                      reforce: reforce,
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
