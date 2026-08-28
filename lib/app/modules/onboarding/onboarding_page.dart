import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/modules/onboarding/pages/step1.dart';
import 'package:idee_pet/app/modules/onboarding/pages/step2.dart';
import 'package:idee_pet/lib.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    OnboardingProfileStep1(),
                    OnboardingProfileStep2(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
