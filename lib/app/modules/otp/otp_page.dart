import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/lib.dart';

class OtpPage extends BasePage<OtpController> {
  const OtpPage({super.key}) : super(showBottomNavigation: false);

  @override
  Widget body(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Confirme seu e-mail',
                    style: AppTextStyles.title(fontSize: 28).style,
                  ),
                  Text(
                    'Enviamos um código para seu e-mail.\nInsira-o abaixo para ativar sua conta.',
                    style: AppTextStyles.subtitleBold().style,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PinInputField(
                        controller: controller.pin1,
                        onChanged: (value) => controller.setPin1(value),
                        isFirst: true,
                      ),
                      PinInputField(
                        controller: controller.pin2,
                        onChanged: (value) => controller.setPin2(value),
                      ),
                      PinInputField(
                        controller: controller.pin3,
                        onChanged: (value) => controller.setPin3(value),
                      ),
                      PinInputField(
                        controller: controller.pin4,
                        onChanged: (value) => controller.setPin4(value),
                      ),
                      PinInputField(
                        controller: controller.pin5,
                        onChanged: (value) => controller.setPin5(value),
                      ),
                      PinInputField(
                        controller: controller.pin6,
                        onChanged: (value) => controller.setPin6(value),
                        isLast: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Não recebeu o código?',
                      style: AppTextStyles.mulishBold(
                        color: AppColors.fontColorSubtitle,
                      ).style,
                    ),
                  ),
                  Obx(
                    () => Align(
                      alignment: Alignment.center,
                      child: controller.canResendCode.isTrue
                          ? TextButton(
                              onPressed: controller.reSendCode,
                              child: Text(
                                'Solicite um novo código',
                                style: AppTextStyles.mulishRegular(
                                        color: AppColors.primary,
                                        decoration: TextDecoration.underline)
                                    .style,
                              ),
                            )
                          : Text(
                              'Solicite um novo código em ${controller.formattedTime()}',
                              style: AppTextStyles.mulishRegular(
                                      color: AppColors.greyWeak,
                                      decoration: TextDecoration.underline)
                                  .style,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () {
              return controller.isLoading.isTrue
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : CustomButton.filled(
                      action: controller.isPinComplete ? controller.next : null,
                      title: Text(
                        'Verificar',
                        style: AppTextStyles.poppinsSemiBold(
                          color: AppColors.background,
                        ).style,
                      ),
                    );
            },
          ),
          SizedBox(height: 10),
        ],
      );
}
