import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) => Divider(
        color: AppColors.dividerColor,
        height: 1,
      );
}
