import 'package:flutter/material.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/helps/date_time.dart';
import 'package:idee_pet/app/core/core_old/widgets/dialogs.dart';
import 'package:idee_pet/app/core/core_old/widgets/svgs.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class MedicalRecordCard extends StatelessWidget {
  final MedicalRecordResponse medRecord;
  final void Function(String id) delete;
  const MedicalRecordCard({
    super.key,
    required this.medRecord,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Alinha o ícone no topo
              children: [
                Expanded(
                  child: Text(
                    medRecord.title,
                    style: AppTextStyles.poppinsMedium(
                            fontSize: 15, color: AppColors.fontColorSubtitle)
                        .style,
                  ),
                ),
                InkWell(
                  onTap: () {
                    DialogApp.showOkCancelDialog(
                      context,
                      'Remover prontuário',
                      ' Tem certeza de que deseja remover este prontuário? Esta ação não pode ser desfeita.',
                      () {
                        delete(medRecord.id);
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: CustomLogo.healthTrash(
                    width: 14,
                    height: 17,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            medRecord.date != null
                ? Text(
                    formatDayMonthYear(medRecord.date),
                    style: AppTextStyles.poppinsMedium(
                            fontSize: 11, color: AppColors.fontColorSubtitle)
                        .style,
                  )
                : Text(
                    'Adicionar data de prontuário',
                    style: AppTextStyles.poppinsMedium(
                            fontSize: 11, color: AppColors.selectYellow)
                        .style,
                  ),
          ],
        ),
      ),
    );
  }
}

class MedRecordCardEmpty extends StatelessWidget {
  final MedicalRecordResponse medRecord;
  const MedRecordCardEmpty({
    super.key,
    required this.medRecord,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Alinha o ícone no topo
              children: [
                Expanded(
                  child: Text(
                    medRecord.title,
                    style: AppTextStyles.poppinsMedium(
                            fontSize: 15, color: AppColors.fontColorSubtitle)
                        .style,
                  ),
                ),
                Icon(
                  Icons.delete,
                  color: AppColors.primary,
                ), // Ícone no topo direito
              ],
            ),
            const SizedBox(height: 4),
            medRecord.date != null
                ? Text(
                    formatDayMonthYear(medRecord.date),
                    style: AppTextStyles.poppinsMedium(
                            fontSize: 11, color: AppColors.fontColorSubtitle)
                        .style,
                  )
                : Text(
                    'Adicionar data de prontuário',
                    style: AppTextStyles.poppinsMedium(
                            fontSize: 11, color: AppColors.selectYellow)
                        .style,
                  ),
          ],
        ),
      ),
    );
  }
}
