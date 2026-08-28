import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/modules/biometrics/biometrics_controller.dart';
import 'package:idee_pet/app/core/core_old/widgets/buttons.dart';
import 'package:idee_pet/app/core/core_old/widgets/svgs.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/core/enum/pet_type_enum.dart';

class BiometricsStep7Page extends GetView<BiometricsController> {
  const BiometricsStep7Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomLogo.logoIcon(
          width: 80,
          height: 60,
        ),
        SizedBox(height: 14),
        Text(
          'Conta Criada!',
          style: AppTextStyles.title(fontSize: 26).style,
        ),
        SizedBox(height: 2),
        Text(
          'Agora você pode acessar sua conta\ne aproveitar todos os benefícios\ndo Idee Pet.',
          style: AppTextStyles.robotoMedium(fontSize: 16).style,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 14),
        controller.appStateService.pets.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: CustomButton.transparent(
                  title: Text(
                    'Cadastrar outro animal',
                    style: AppTextStyles.poppinsSemiBold(fontSize: 15).style,
                  ),
                  action: controller.goToNewPet,
                ),
              )
            : SizedBox(),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: CustomButton.filled(
              title: Text(
                'Tela principal',
                style: AppTextStyles.poppinsSemiBold(
                        fontSize: 15, color: Colors.white)
                    .style,
              ),
              action: controller.goToHome),
        ),
        SizedBox(height: 56),
        controller.pet.type == PetType.dog
            ? SvgPicture.asset(
                'assets/onboarding_biometric/dog5.svg',
                width: double.infinity,
                height: 210,
              )
            : SvgPicture.asset(
                'assets/onboarding_biometric/cat5.svg',
                width: double.infinity,
                height: 210,
              ),
      ],
    );
  }
}
