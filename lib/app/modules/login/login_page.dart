import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 60),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLogo.logoIcon(
                width: 56,
                height: 56,
              ),
              SizedBox(height: 34),
              Text(
                'Bem-vindo',
                style: AppTextStyles.title().style,
              ),
              Text(
                'Entre ou cadastre-se para criar a identidade única do seu pet e protegê-lo para sempre.',
                style: AppTextStyles.subtitle().style,
                overflow: TextOverflow.visible,
              ),
              SizedBox(height: 24),
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
              SizedBox(height: 24),
              Obx(
                () => AppTextField(
                  controller: controller.passwordController,
                  erroText: controller.passwordError(),
                  onChanged: (_) => controller.validate(),
                  textInputAction: TextInputAction.done,
                  bordercolor: Colors.transparent,
                  cursorColor: AppColors.primary,
                  hintText: 'Senha',
                  hidePassword: true,
                  maxLines: 1,
                ),
              ),
              Align(
                child: TextButton(
                  onPressed: controller.forgotPassword,
                  child: Text(
                    'Esqueceu sua senha?',
                    style: AppTextStyles.poppinsSemiBold(
                            color: AppColors.primary, fontSize: 12)
                        .style,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => controller.isLoading.isTrue
                    ? Center(
                        child: LinearProgressIndicator(),
                      )
                    : CustomButton.filled(
                        action: controller.canProceed.isTrue
                            ? () {
                                controller.signIn();
                              }
                            : null,
                        title: Text(
                          'Entrar',
                          style: AppTextStyles.poppinsSemiBold(
                            color: AppColors.background,
                          ).style,
                        ),
                      ),
              ),
              SizedBox(height: 16),
              CustomButton.transparent(
                action: controller.gotoCrteateAccount,
                title: Text(
                  'Criar conta',
                  style: AppTextStyles.poppinsSemiBold(
                    color: AppColors.primary,
                  ).style,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
