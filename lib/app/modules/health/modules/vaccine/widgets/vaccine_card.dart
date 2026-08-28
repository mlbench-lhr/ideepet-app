import 'package:flutter/material.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/modules/health/modules/vaccine/repository/dtos/request/edit_vaccine_request.dart';
import 'package:idee_pet/app/modules/health/modules/vaccine/widgets/dialog_edit_vaccine.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/helps/date_time.dart';
import 'package:idee_pet/app/core/core_old/widgets/dialogs.dart';
import 'package:idee_pet/app/core/core_old/widgets/svgs.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class VaccineCard extends StatelessWidget {
  final VaccineResponse vaccine;
  final Future<void> Function(VaccineResponse vaccine) delete;
  final Future<void> Function(EditVaccineRequest request) edit;
  final Pet pet;
  final bool loading;
  const VaccineCard({
    super.key,
    required this.vaccine,
    required this.delete,
    required this.edit,
    required this.pet,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showEditVaccineDialog(
          context,
          pet,
          loading,
          edit,
          vaccine,
        );
      },
      child: Card(
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
                    child: Row(
                      children: [
                        Text(
                          vaccine.title,
                          style: AppTextStyles.poppinsMedium(
                                  fontSize: 15,
                                  color: AppColors.fontColorSubtitle)
                              .style,
                        ),
                        SizedBox(width: 4),
                        vaccine.isAdministered
                            ? Icon(Icons.check_circle, color: AppColors.primary)
                            : SizedBox(),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      DialogApp.showOkCancelDialog(
                        context,
                        'Remover Vacina',
                        ' Tem certeza de que deseja remover esta vacina? Esta ação não pode ser desfeita.',
                        () {
                          delete(vaccine);
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
              vaccine.date != null
                  ? Text(
                      formatDayMonthYear(vaccine.date),
                      style: AppTextStyles.poppinsMedium(
                              fontSize: 11, color: AppColors.fontColorSubtitle)
                          .style,
                    )
                  : Text(
                      'Adicionar data de vacinação',
                      style: AppTextStyles.poppinsMedium(
                              fontSize: 11, color: AppColors.selectYellow)
                          .style,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class VaccineCardEmpty extends StatelessWidget {
  final VaccineResponse vaccine;
  const VaccineCardEmpty({
    super.key,
    required this.vaccine,
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
                    vaccine.title,
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
            vaccine.date != null
                ? Text(
                    formatDayMonthYear(vaccine.date),
                    style: AppTextStyles.poppinsMedium(
                            fontSize: 11, color: AppColors.fontColorSubtitle)
                        .style,
                  )
                : Text(
                    'Adicionar data de vacinação',
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
