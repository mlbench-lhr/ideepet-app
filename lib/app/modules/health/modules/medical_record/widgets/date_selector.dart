import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/widgets/calendar.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/helps/date_time.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/core/core_old/widgets/textfield.dart';

class DateSelectorWidget extends StatefulWidget {
  final DateTime? initialDate;
  final void Function(DateTime) onDateSelected;
  final String hintText;
  const DateSelectorWidget({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
    required this.hintText,
  });

  @override
  State<DateSelectorWidget> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelectorWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      controller.text = formatDayMonthYear(widget.initialDate);
    }
  }

  void onItemSelected(DateTime value) {
    setState(() {
      controller.text = formatDayMonthYear(value);
    });
    widget.onDateSelected(value);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showCalendarModal(
          context: context,
          initialDate: widget.initialDate,
          onDateSelected: onItemSelected,
        );
      },
      child: AppTextField(
        controller: controller,
        textAlign: TextAlign.center,
        bordercolor: Colors.transparent,
        hintText: widget.hintText,
        inputStyle: AppTextStyles.poppinsMedium(
                color: AppColors.fontColorSubtitle, fontSize: 14)
            .style,
        enabled: false,
      ),
    );
  }
}
