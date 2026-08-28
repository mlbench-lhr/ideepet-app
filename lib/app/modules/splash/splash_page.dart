import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/svgs.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Obx(
          () {
            return Stack(
              alignment: Alignment.center,
              children: [
                AnimatedOpacity(
                  duration: const Duration(seconds: 2),
                  opacity: controller.iconLogoOpacity() ? 1.0 : 0.0,
                  child: AnimatedContainer(
                    transform: Matrix4.translationValues(
                      controller.iconNameAnimation() ? -75.0 : 0.0,
                      0.0,
                      0.0,
                    ),
                    height: controller.iconLogoAnimation ? 50 : 120,
                    width: controller.iconLogoAnimation ? 50 : 120,
                    duration: const Duration(milliseconds: 500),
                    child: CustomLogo.logoIcon(),
                  ),
                ),
                AnimatedOpacity(
                  opacity: controller.iconNameAnimation() ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    margin: const EdgeInsets.only(left: 75.0, top: 14),
                    width: 150,
                    height: 150,
                    child: CustomLogo.logoName(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const LinearProgressIndicator(
        backgroundColor: AppColors.background,
        color: AppColors.primary,
      ),
    );
  }
}
