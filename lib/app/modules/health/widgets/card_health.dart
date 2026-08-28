import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/svgs.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/core/models/pet.entity.dart';

class CardHealth extends StatelessWidget {
  final Pet pet;
  final String? address;
  const CardHealth({super.key, required this.pet, required this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ColumnText(line1: 'Idade', line2: pet.getAge()),
                        ColumnText(
                            line1: 'Porte', line2: pet.size?.label ?? ''),
                        ColumnText(
                            line1: 'Peso', line2: pet.weight?.label ?? ''),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // ColumnText(line1: 'Localização', line2: address ?? ''),
                ],
              ),
            ),
            CustomLogo.healthDog(
              width: 65,
              height: 65,
            ),
          ],
        ),
      ),
    );
  }
}

class ColumnText extends StatelessWidget {
  final String line1;
  final String line2;
  const ColumnText({super.key, required this.line1, required this.line2});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(line1,
            style: AppTextStyles.poppinsSemiBold(
                    fontSize: 12, color: AppColors.grey)
                .style),
        SizedBox(height: 3),
        Text(
          line2,
          style: AppTextStyles.poppinsMedium(fontSize: 12).style,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
