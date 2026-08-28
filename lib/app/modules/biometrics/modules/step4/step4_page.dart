import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/modules/biometrics/biometrics_controller.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/core/enum/pet_type_enum.dart';

class BiometricsStep4Page extends GetView<BiometricsController> {
  const BiometricsStep4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 60),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(),
            controller.pet.type == PetType.dog
                ? SvgPicture.asset(
                    'assets/onboarding_biometric/dog3.svg',
                    width: double.infinity,
                    height: 210,
                  )
                : SvgPicture.asset(
                    'assets/onboarding_biometric/cat3.svg',
                    width: double.infinity,
                    height: 210,
                  ),
            const SizedBox(height: 20),
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Posicione a câmera\na cerca de 15 cm\n do focinho do seu pet',
                  textAlign: TextAlign.start,
                  style:
                      AppTextStyles.title(fontSize: 19, color: Colors.black12)
                          .style,
                ),
                Text(
                  'Certifique-se de que o\nfocinho esteja bem\niluminado e em foco',
                  textAlign: TextAlign.start,
                  style:
                      AppTextStyles.title(fontSize: 19, color: Colors.black12)
                          .style,
                ),
                Text(
                  'Mantenha seu pet calmo\ne imóvel durante o\nprocesso',
                  textAlign: TextAlign.start,
                  style: AppTextStyles.title(fontSize: 19).style,
                ),
                Text(
                  'Evite obstruções como\nsujeira ou objetos\npróximos ao focinho',
                  textAlign: TextAlign.start,
                  style:
                      AppTextStyles.title(fontSize: 19, color: Colors.black12)
                          .style,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
