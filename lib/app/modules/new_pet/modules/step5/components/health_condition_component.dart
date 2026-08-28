import 'package:flutter/material.dart';
import 'package:idee_pet/app/modules/health/modules/medical_record/widgets/date_selector.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/dropdown.dart';
import 'package:idee_pet/app/core/core_old/widgets/textfield.dart';

class HealthConditionComponent extends StatelessWidget {
  const HealthConditionComponent({
    super.key,
    required this.changeConditionText,
    required this.changeDateCondition,
    required this.changeSeverity,
    required this.selectedSeverity,
    required this.selectedDate,
    required this.severityList,
    required this.healthConditionName,
    required this.textEditingController,
  });

  final Function(String) changeConditionText;
  final Function(DateTime) changeDateCondition;
  final Function(String) changeSeverity;

  final String selectedSeverity;
  final DateTime selectedDate;
  final String healthConditionName;

  final List<String> severityList;

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: textEditingController,
          keyboardType: TextInputType.text,
          onChanged: (value) => changeConditionText(value),
          textInputAction: TextInputAction.next,
          bordercolor: Colors.transparent,
          cursorColor: AppColors.primary,
          labeltext: 'Condição de saúde',
          hintText: 'Condição de saúde',
          maxLines: 1,
        ),
        SizedBox(height: 24),
        AppDropdownSearch(
          selectedItem: selectedSeverity,
          hintText: 'Selecione a severidade',
          items: severityList,
          onChanged: (value) {
            value != null ? changeSeverity(value.toString()) : '';
          },
        ),
        SizedBox(height: 24),
        DateSelectorWidget(
            initialDate: selectedDate,
            onDateSelected: changeDateCondition,
            hintText: 'Data do diagnóstico'),
      ],
    );
  }
}
