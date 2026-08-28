import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/buttons.dart';
import 'package:idee_pet/app/core/core_old/widgets/svgs.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class NewPasswordSuccessPage extends BasePage<NewPasswordSuccessController> {
  const NewPasswordSuccessPage({super.key})
      : super(showBottomNavigation: false);

  @override
  Widget body(BuildContext context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLogo.newPasswordSuccess(
              width: Get.width,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Senha alterada\ncom sucesso!',
              style: AppTextStyles.title(fontSize: 34).style,
              textAlign: TextAlign.center,
            ),
            Text(
              'Agora você pode acessar sua\nconta com a nova senha.',
              style: AppTextStyles.subtitle().style,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 60,
            ),
            CustomButton.filled(
              action: controller.goToLogin,
              title: Text(
                'Ir para Login',
                style: AppTextStyles.poppinsSemiBold(
                  color: AppColors.background,
                ).style,
              ),
            ),
          ],
        ),
      );
}
