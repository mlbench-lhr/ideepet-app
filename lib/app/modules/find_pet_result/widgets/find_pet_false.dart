import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/buttons.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class FindPetFalse extends StatelessWidget {
  final VoidCallback action;

  const FindPetFalse({
    super.key,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              icon: CircleAvatar(
                backgroundColor: AppColors.greyWhite,
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                ),
              ),
              onPressed: () => action(),
            ),
            SizedBox(height: 20),
            Text(
              'Pet não encontrado',
              style: AppTextStyles.title(fontSize: 24).style,
            ),
            Text(
              'Este pet ainda não está cadastrado\nem nossa base.',
              style: AppTextStyles.subtitle().style,
            ),
            Spacer(),
            Center(
              child: SvgPicture.asset(
                'assets/find_pet/not_found.svg',
              ),
            ),
            Spacer(),
            CustomButton.filled(
              action: () => action(),
              title: Text(
                'Voltar',
                style: AppTextStyles.poppinsSemiBold(
                  color: AppColors.background,
                ).style,
              ),
            )
          ],
        ),
      ),
    );
  }
}
