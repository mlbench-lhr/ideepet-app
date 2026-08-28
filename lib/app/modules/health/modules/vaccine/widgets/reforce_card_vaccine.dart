import 'package:flutter/material.dart';
import 'package:idee_pet/app/modules/health/modules/vaccine/repository/dtos/dtos.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/helps/date_time.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class ReforceCardVaccine extends StatelessWidget {
  final VaccineResponse vaccine;
  const ReforceCardVaccine({
    super.key,
    required this.vaccine,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryVariant,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 2,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.selectYellow,
                ),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    'Atualize o histórico de vacinas',
                    style: AppTextStyles.poppinsMedium(
                            color: AppColors.selectYellow, fontSize: 10)
                        .style,
                  ),
                ),
              ],
            ),
            Text(
              'Próxima vacina',
              style: AppTextStyles.poppinsSemiBold(
                      color: AppColors.background, fontSize: 12)
                  .style,
            ),
            Row(
              children: [
                Text(
                  vaccine.title,
                  style: AppTextStyles.poppinsExtraBold(
                          color: AppColors.background, fontSize: 12)
                      .style,
                ),
                Text(
                  ' (2° dose)',
                  style: AppTextStyles.poppinsMedium(
                          color: AppColors.background, fontSize: 12)
                      .style,
                ),
              ],
            ),
            Text(
              formatDayMonthYear(vaccine.reforce),
              style: AppTextStyles.poppinsSemiBold(
                      color: AppColors.background, fontSize: 12)
                  .style,
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
