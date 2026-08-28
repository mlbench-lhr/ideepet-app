import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class NewPasswordPage extends BasePage<NewPasswordController> {
  const NewPasswordPage({super.key}) : super(showBottomNavigation: false);

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
              onPressed: controller.back,
            ),
            const SizedBox(height: 20),
            Text(
              'Crie uma nova senha',
              style: AppTextStyles.title(fontSize: 34).style,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 8),
            Text(
              'Sua nova senha deve ser diferente da que já foi utilizada.',
              style: AppTextStyles.subtitle().style,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 20),
            Obx(
              () => AppTextField(
                controller: controller.passwordController,
                erroText: controller.passwordError(),
                onChanged: (_) => controller.validate(),
                textInputAction: TextInputAction.done,
                bordercolor: Colors.transparent,
                cursorColor: AppColors.primary,
                hintText: 'Nova senha',
                hidePassword: true,
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => AppTextField(
                controller: controller.confirmPasswordController,
                erroText: controller.confirmPasswordError(),
                onChanged: (_) => controller.validate(),
                textInputAction: TextInputAction.done,
                bordercolor: Colors.transparent,
                cursorColor: AppColors.primary,
                hintText: 'Confirme a nova senha',
                hidePassword: true,
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
          ],
        ),
      );
}
