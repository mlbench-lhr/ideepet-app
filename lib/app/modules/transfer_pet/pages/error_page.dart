import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/buttons.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/modules/transfer_pet/transfer_pet_controller.dart';

import '../../../core/base/base_page.dart';

class ErrorPage extends BasePage<TransferPetController> {
  const ErrorPage({super.key}) : super(showBottomNavigation: false);

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Tutor não\nencontrado',
                  style: AppTextStyles.title(fontSize: 28).style,
                ),
                SizedBox(height: 10),
                Text(
                  'Não encontramos nenhum tutor\ncom essas informações.',
                  style: AppTextStyles.subtitle().style,
                ),
                SizedBox(height: 10),
                Center(
                  child: SvgPicture.asset(
                    'assets/find_pet/not_found.svg',
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomButton.filled(
          action: () => controller.retry(),
          title: Text(
            'Tentar novamente',
            style: AppTextStyles.poppinsSemiBold(
              color: AppColors.background,
            ).style,
          ),
        ),
        const SizedBox(height: 10),
        CustomButton.transparent(
          action: () => Get.back(),
          title: Text(
            'Cancelar',
            style: AppTextStyles.poppinsSemiBold(
              color: AppColors.primary,
            ).style,
          ),
        ),
      ],
    );
  }
}
