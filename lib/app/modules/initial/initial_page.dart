import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/modules/initial/initial_controller.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/buttons.dart';
import 'package:idee_pet/app/core/core_old/widgets/svgs.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/modules/initial/widgets/circular_button.dart';

class InitialPage extends GetView<InitialController> {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 30),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: CustomLogo.logoIcon(width: 46, height: 46),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.021),
            Text(
              'Olá, somos\no iDee Pet!',
              style: AppTextStyles.title().style,
            ),
            Text(
              'Vamos criar um vínculo\ninesquecível com o seu Pet!',
              style: AppTextStyles.subtitle().style,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.012),
            Align(
              alignment: Alignment.center,
              child: CustomLogo.pets(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.013),
            CustomButton.filled(
              action: controller.goToOnboarding,
              title: Text(
                'Começar',
                style: AppTextStyles.poppinsSemiBold(
                  color: AppColors.background,
                ).style,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            CustomButton.transparent(
              action: controller.goToLogin,
              title: Text(
                'Já tem uma conta? Faça login',
                style: AppTextStyles.poppinsSemiBold(
                  color: AppColors.primary,
                ).style,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.0625),
            CircularButton(onPressed: controller.goToFindPet),
            Center(
              child: Text('Encontrar Pet',
                  style: AppTextStyles.poppinsMedium(fontSize: 14).style),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
          ],
        ),
      ),
    );
  }
}
