import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/svgs.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/core/models/pet.entity.dart';

class CardFoodWidget extends StatelessWidget {
  final Pet pet;
  final double? elevation;
  final void Function() goToEditFood;
  const CardFoodWidget(
      {super.key,
      required this.pet,
      required this.elevation,
      required this.goToEditFood});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: goToEditFood,
      child: Card(
        elevation: elevation,
        color: AppColors.buttonColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // Envolve o Column para que o Wrap possa quebrar corretamente
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Comidinhas prediletas',
                      style: AppTextStyles.title(fontSize: 14).style,
                    ),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        if (pet.foods.isEmpty)
                          Text('Sem comidinhas selecionadas',
                              style: AppTextStyles.poppinsMedium(
                                      fontSize: 9, color: AppColors.primary)
                                  .style),
                        for (int i = 0; i < pet.foods.length; i++) ...[
                          Text(
                            '${pet.foods[i]}${pet.foods.last == pet.foods[i] ? '.' : ','}',
                            style: AppTextStyles.poppinsMedium(
                                    fontSize: 9, color: AppColors.primary)
                                .style,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              CustomLogo.homeFood(height: 50, width: 50),
            ],
          ),
        ),
      ),
    );
  }
}
