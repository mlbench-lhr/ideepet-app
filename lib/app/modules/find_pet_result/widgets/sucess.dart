import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class SucessFindPet extends StatelessWidget {
  final bool containsData;
  const SucessFindPet({super.key, required this.containsData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24,
          children: [
            const Spacer(),
            CustomLogo.logoIcon(
              width: 56,
              height: 56,
            ),
            Text(
              'Obrigado!',
              style: AppTextStyles.title(fontSize: 28).style,
            ),
            Text(
              containsData
                  ? 'Suas informações e a localização\njá foram enviadas ao tutor.'
                  : 'O tutor receberá apenas a localização\nonde o pet foi encontrado.',
              style: AppTextStyles.subtitle(fontSize: 18).style,
            ),
            Image.asset(
              'assets/find_pet/sucess.png',
              width: MediaQuery.of(context).size.width * 0.9,
            ),
            const Spacer(),
            CustomButton.filled(
                title: Text(
                  'Menu inicial',
                  style: TextStyle(color: AppColors.white),
                ),
                action: () {
                  Get.back();
                  Get.back();
                  Get.back();
                  if (containsData) {
                    Get.back();
                  }
                })
          ],
        ),
      ),
    );
  }
}
