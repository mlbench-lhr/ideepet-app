import 'package:flutter/material.dart';

import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:intl/intl.dart';

class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    super.key,
    required this.onChanged,
    this.label,
    required this.date,
  });

  final String? label;
  final Function(DateTime) onChanged;
  final DateTime date;

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  late DateTime _selectedDate;
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.date;
    _updateFormattedDate();
  }

  void _updateFormattedDate() {
    formattedDate = DateFormat('dd/MM/yyyy').format(_selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      helpText: 'Selecione uma data',
      cancelText: 'Fechar',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.secundary,
              onSurface: AppColors.fontColorSubtitle,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _updateFormattedDate();
      });
      widget.onChanged(_selectedDate);
    }
  }

  @override
  void didUpdateWidget(covariant AppDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.date != oldWidget.date) {
      setState(() {
        _selectedDate = widget.date;
        _updateFormattedDate();
      });
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _selectDate(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.label ?? 'Selecione a data'),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.textfield.withOpacity(0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedDate,
                    style: AppTextStyles.poppinsSemiBold(
                      color: AppColors.fontColorSubtitle,
                    ).style,
                  ),
                  const Icon(Icons.calendar_month_outlined)
                ],
              ),
            ),
          ],
        ),
      );
}
