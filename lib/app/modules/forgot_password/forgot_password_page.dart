import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class ForgotPasswordPage extends BasePage<ForgotPasswordController> {
  const ForgotPasswordPage({super.key}) : super(showBottomNavigation: false);

  @override
  Widget body(BuildContext context) => SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              icon: CircleAvatar(
                backgroundColor: AppColors.greyWhite,
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                ),
              ),
              onPressed: controller.goToLogin,
            ),
            const SizedBox(height: 20),
            Text(
              'Esqueceu sua senha?',
              style: AppTextStyles.title(fontSize: 34).style,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 8),
            Text(
              'Por favor, insira o endereço de e-mail vinculado à sua conta.',
              style: AppTextStyles.subtitle().style,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 20),
            Obx(
              () => AppTextField(
                controller: controller.emailController,
                erroText: controller.emailError(),
                onChanged: (_) => controller.validate(),
                textInputAction: TextInputAction.next,
                bordercolor: Colors.transparent,
                cursorColor: AppColors.primary,
                hintText: 'E-mail',
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 30),
            Obx(
              () => controller.isLoading.isTrue
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : CustomButton.filled(
                      action: controller.canContinue.isTrue
                          ? controller.next
                          : null,
                      title: Text(
                        'Prosseguir',
                        style: AppTextStyles.poppinsSemiBold(
                          color: AppColors.background,
                        ).style,
                      ),
                    ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lembrou da sua senha? ',
                  style: AppTextStyles.poppinsSemiBold(
                    color: AppColors.primary,
                    fontSize: 12,
                  ).style,
                ),
                TextButton(
                  onPressed: controller.goToLogin,
                  child: Text(
                    'Faça o login',
                    style: AppTextStyles.poppinsSemiBold(
                      color: AppColors.makeLoginTextButtonColor,
                      fontSize: 12,
                    ).style,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      );
}
