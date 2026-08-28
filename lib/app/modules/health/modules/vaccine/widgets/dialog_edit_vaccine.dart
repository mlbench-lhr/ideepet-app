import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

void showEditVaccineDialog(
  BuildContext context,
  Pet pet,
  bool loading,
  Future<void> Function(EditVaccineRequest request) editVaccine,
  VaccineResponse vaccineResponse,
) {
  final vaccine = TextEditingController(text: vaccineResponse.title);
  final lote = TextEditingController(text: vaccineResponse.lote);
  DateTime? date = vaccineResponse.date;
  DateTime? reforce = vaccineResponse.reforce;

  void setDate(DateTime value) {
    date = value;
  }

  void setReforce(DateTime value) {
    reforce = value;
  }

  PetWeight? selectedWeight =
      petWeightfromDouble(pet.type, vaccineResponse.weight);
  List<PetWeight> listWeights;
  if (pet.type == PetType.dog) {
    listWeights = DogWeight.values;
  } else {
    listWeights = CatWeight.values;
  }
  void selectWeight(PetWeight? weight) => selectedWeight = weight;
  var isAdministered = vaccineResponse.isAdministered.obs;

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
          },
          child: SingleChildScrollView(
            child: GetBuilder<VaccineController>(
              builder: (controller) => Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vaccineResponse.title,
                    style: AppTextStyles.poppinsSemiBold(
                      fontSize: 14,
                      color: AppColors.primary,
                    ).style,
                  ),
                  AppTextField(
                    bordercolor: Colors.transparent,
                    hintText: 'Vacina',
                    controller: vaccine,
                    //onTapOutside: () => FocusScope.of(context).nextFocus(),
                  ),
                  AppTextField(
                    bordercolor: Colors.transparent,
                    hintText: 'Lote',
                    controller: lote,
                    onTapOutside: () => FocusScope.of(context).nextFocus(),
                  ),
                  BottomSheetSelector(
                    onSelected: selectWeight,
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
                          onDateSelected: setDate,
                          hintText: 'Data',
                        ),
                      ),
                      Flexible(
                        child: DateSelector(
                          initialDate: reforce,
                          onDateSelected: setReforce,
                          hintText: 'Reforço',
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Obx(
                      () {
                        return ElevatedButton.icon(
                          onPressed: () {
                            isAdministered(!isAdministered());
                          },
                          icon: Icon(
                            isAdministered()
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: isAdministered() ? Colors.green : Colors.red,
                          ),
                          label: Text(isAdministered()
                              ? "Administrada"
                              : "Não administrada"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isAdministered()
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                            foregroundColor: Colors.black,
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Obx(() => controller.loadingCreateVaccine.isTrue
                        ? LinearProgressIndicator()
                        : ElevatedButton(
                            onPressed: loading
                                ? null
                                : () async {
                                    await editVaccine(
                                      EditVaccineRequest(
                                        title: vaccine.text,
                                        lote: lote.text,
                                        weight: selectedWeight?.value,
                                        petId: pet.id,
                                        date: date,
                                        reforce: reforce,
                                        isAdministered: isAdministered(),
                                        oldData: vaccineResponse,
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
                                        'Editar',
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
        ),
      );
    },
  );
}
