import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/buttons.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/modules/transfer_pet/transfer_pet_controller.dart';
import 'package:idee_pet/app/modules/transfer_pet/widgets/tile_tutor.dart';

import '../../../core/base/base_page.dart';

class SucessPage extends BasePage<TransferPetController> {
  const SucessPage({super.key}) : super(showBottomNavigation: false);

  @override
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                  icon: CircleAvatar(
                    backgroundColor: AppColors.greyWhite,
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.primary,
                    ),
                  ),
                  onPressed: () => controller.goBack(),
                ),
                SizedBox(height: 10),
                Text(
                  'Confirmar\ntransferência',
                  style: AppTextStyles.title(fontSize: 28).style,
                ),
                SizedBox(height: 10),
                Text(
                  'Tutor localizado! Deseja confirmar\na transferência deste pet?',
                  style: AppTextStyles.subtitle().style,
                ),
                SizedBox(height: 10),
                TilteTutor(
                  tutor: controller.tutor!,
                ),
                const SizedBox(height: 20),
                Center(
                    child: SvgPicture.asset(
                        'assets/onboarding_biometric/cat2.svg')),
              ],
            ),
          ),
        ),
        Obx(() {
          return CustomButton.filled(
            action: controller.isEmailValid.value ? () {} : null,
            title: Text(
              'Confirmar',
              style: AppTextStyles.poppinsSemiBold(
                color: AppColors.background,
              ).style,
            ),
          );
        }),
        const SizedBox(height: 20),
        Obx(() {
          return CustomButton.transparent(
            action: controller.isEmailValid.value ? () {} : null,
            title: Text(
              'Cancelar',
              style: AppTextStyles.poppinsSemiBold(
                color: AppColors.primary,
              ).style,
            ),
          );
        }),
      ],
    );
  }
}
