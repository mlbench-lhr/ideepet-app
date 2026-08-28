import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class WalletData extends StatelessWidget {
  final String title;
  final String subtitle;
  const WalletData({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              AppTextStyles.poppinsLight(fontSize: 9, color: AppColors.primary)
                  .style,
          overflow: TextOverflow.clip,
        ),
        Text(
          subtitle,
          style: AppTextStyles.poppinsSemiBold(
                  fontSize: 13, color: AppColors.primary)
              .style,
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }
}
