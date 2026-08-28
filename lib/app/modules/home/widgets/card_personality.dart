import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/svgs.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/core/models/pet.entity.dart';

class CardPersonalityWidget extends StatelessWidget {
  final Pet pet;
  final double? elevation;
  final void Function() goToEditPersonality;
  const CardPersonalityWidget(
      {super.key,
      required this.pet,
      required this.elevation,
      required this.goToEditPersonality});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: goToEditPersonality,
      child: Card(
        elevation: elevation,
        color: AppColors.cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: SizedBox(
            //height: 60,
            child: Row(
              children: [
                CustomLogo.homePersonality(height: 50, width: 50),
                SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (pet.personalitys.isEmpty)
                        Text('Sem personalidades selecionadas',
                            style: AppTextStyles.poppinsMedium(
                                    fontSize: 9, color: AppColors.background)
                                .style),
                      if (pet.personalitys.isNotEmpty)
                        Text(
                          pet.personalitys.first.title,
                          style: AppTextStyles.poppinsMedium(
                                  fontSize: 12, color: AppColors.background)
                              .style,
                        ),
                      if (pet.personalitys.length > 1)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: [
                              for (int i = 1;
                                  i < pet.personalitys.length;
                                  i++) ...[
                                if (i > 1)
                                  Text('•',
                                      style: AppTextStyles.poppinsMedium(
                                              fontSize: 9,
                                              color: AppColors.background)
                                          .style),
                                Text(pet.personalitys[i].title,
                                    style: AppTextStyles.poppinsMedium(
                                            fontSize: 9,
                                            color: AppColors.background)
                                        .style),
                              ],
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Alterar personalidade',
                      style: AppTextStyles.poppinsLight(
                              fontSize: 10, color: AppColors.fontColorSubtitle)
                          .style,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
