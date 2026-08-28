import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:idee_pet/app/modules/new_pet/new_pet_controller.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/buttons.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class FirstPet extends GetView<NewPetController> {
  const FirstPet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/onboarding/wallpaper_dog.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: AppColors.fontColorSubtitle.withValues(alpha: 0.45),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A identidade\núnica do seu pet.',
                style:
                    AppTextStyles.poppinsExtraBold(color: AppColors.background)
                        .style,
              ),
              SizedBox(height: 40),
              CustomButton.filled(
                action: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => OnboardingBiometry(
                  //       id: 'widget.controller.petId!',
                  //       type: PetType.cat,
                  //     ),
                  //   ),
                  // );
                  controller.nextPage(context);
                },
                title: Text(
                  'Continuar',
                  style: AppTextStyles.poppinsSemiBold(
                    color: AppColors.background,
                  ).style,
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
