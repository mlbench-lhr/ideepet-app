import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/core/core_old/widgets/textfield.dart';

class PinInputField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final bool isFirst;
  final bool isLast;

  const PinInputField({
    super.key,
    required this.controller,
    this.onChanged,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 41,
      child: AppTextField(
        padding: EdgeInsets.zero,
        controller: controller,
        hintText: '0',
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }

          if (value.isNotEmpty) {
            if (isLast) {
              FocusScope.of(context).unfocus();
            } else {
              FocusScope.of(context).nextFocus();
            }
          } else {
            if (!isFirst) {
              FocusScope.of(context).previousFocus();
            }
          }
        },
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        bordercolor: Colors.transparent,
        textAlign: TextAlign.center,
        inputStyle: AppTextStyles.mulishRegular(
          color: AppColors.fontColorSubtitle,
          fontSize: 16,
        ).style,
        hintStyle: TextStyle(fontSize: 14, color: AppColors.greyWeak),
      ),
    );
  }
}
