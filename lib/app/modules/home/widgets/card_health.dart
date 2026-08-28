import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/svgs.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class CardHealthWidget extends StatelessWidget {
  const CardHealthWidget({
    super.key,
    required this.onTap,
    this.elevation,
  });
  final double? elevation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          color: AppColors.buttonColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Texto e botões
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Área de saúde',
                        style: AppTextStyles.title(fontSize: 16).style,
                      ),
                      Text(
                        'Gerencie vacinas,\nmedicações e prontuários.',
                        style: AppTextStyles.poppinsMedium(fontSize: 10).style,
                      ),
                      SizedBox(height: 6),
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.greyWhite,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 14),
                            child: Text(
                              'Acessar área de saúde',
                              style: AppTextStyles.poppinsMedium(
                                      fontSize: 10,
                                      color: AppColors.fontColorSubtitle)
                                  .style,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Imagem responsiva
                  Flexible(
                    child: CustomLogo.homePetHealth(
                      height: 94,
                      width: double.infinity, // Usar largura flexível
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -4,
          left: -4,
          child: CustomLogo.homePetHealthCircle(
            height: 25,
            width: 35,
          ),
        ),
      ],
    );
  }
}
