import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/modules/biometric/biometric_controller.dart';

class ResendPage extends GetView<BiometricController> {
  const ResendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.goToBack(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 40),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            IconButton(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              icon: CircleAvatar(
                backgroundColor: AppColors.greyWhite,
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                ),
              ),
              onPressed: () => controller.goToBack(),
            ),
            Expanded(
              child: Center(
                child: Transform.translate(
                  offset: const Offset(12, 0),
                  child: Image.asset(
                    'assets/edit/biometric.png',
                  ),
                ),
              ),
            ),
            CustomButton.filled(
              action: () => controller.sendBiometric(),
              title: Text(
                'Enviar Biometria',
                style: AppTextStyles.poppinsSemiBold(
                  color: AppColors.background,
                ).style,
              ),
            ),
            SizedBox(height: 10),
            CustomButton.transparent(
              action: () => controller.backToBiometricAndReset(),
              title: Text(
                'Refazer Leitura',
                style: AppTextStyles.poppinsSemiBold(
                  color: AppColors.primary,
                ).style,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
