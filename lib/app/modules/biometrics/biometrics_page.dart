import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:idee_pet/app/modules/biometrics/biometrics_controller.dart';
import 'package:idee_pet/app/modules/biometrics/modules/step1/step1_page.dart';
import 'package:idee_pet/app/modules/biometrics/modules/step2/step2_page.dart';
import 'package:idee_pet/app/modules/biometrics/modules/step3/step3_page.dart';
import 'package:idee_pet/app/modules/biometrics/modules/step4/step4_page.dart';
import 'package:idee_pet/app/modules/biometrics/modules/step5/step5_page.dart';
import 'package:idee_pet/app/modules/biometrics/modules/step6/step6_page.dart';
import 'package:idee_pet/app/modules/biometrics/modules/step7/step7_page.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BiometricsPage extends GetView<BiometricsController> {
  const BiometricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      BiometricsStep1Page(),
      BiometricsStep2Page(),
      BiometricsStep3Page(),
      BiometricsStep4Page(),
      BiometricsStep5Page(),
      BiometricsStep6Page(),
      BiometricsStep7Page(),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          if (controller.pageController.page == 0) {
            controller.goToHome();
          } else {
            controller.previosPage();
          }
        }
      },
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                onPageChanged: controller.setCurrentPage,
                children: _pages,
              ),
            ),
            Obx(
              () {
                return controller.currentPage() != 5 &&
                        controller.currentPage() != 6
                    ? Container(
                        color: AppColors.background,
                        padding: const EdgeInsets.only(bottom: 50, top: 8),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            controller.currentPage() != 0
                                ? SizedBox(width: 60)
                                : SizedBox(),
                            SmoothPageIndicator(
                              controller: controller.pageController,
                              count: _pages.length - 2,
                              effect: ExpandingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: AppColors.primary,
                                dotColor: AppColors.greyWeak,
                              ),
                            ),
                            controller.currentPage() != 0
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: SizedBox(
                                      width: 40,
                                      child: IconButton(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 2),
                                        icon: CircleAvatar(
                                          backgroundColor: AppColors.primary,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: AppColors.background,
                                          ),
                                        ),
                                        onPressed: () {
                                          controller.nextPage();
                                        },
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      )
                    : SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
