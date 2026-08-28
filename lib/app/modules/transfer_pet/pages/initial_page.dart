import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/buttons.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:idee_pet/app/core/core_old/widgets/textfield.dart';
import 'package:idee_pet/app/modules/transfer_pet/transfer_pet_controller.dart';

import '../../../core/base/base_page.dart';

class InitialPage extends BasePage<TransferPetController> {
  const InitialPage({super.key}) : super(showBottomNavigation: false);

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
                  'Buscar novo tutor',
                  style: AppTextStyles.title(fontSize: 28).style,
                ),
                SizedBox(height: 10),
                Text(
                  'Digite o e-mail do novo\ntutor para transferir o pet.',
                  style: AppTextStyles.subtitle().style,
                ),
                SizedBox(height: 10),
                Obx(() {
                  return AppTextField(
                    hintText: 'E-mail',
                    controller: controller.email.controller,
                    erroText: controller.email.error.value,
                    onChanged: (_) => controller.email.validate(),
                    bordercolor: Colors.transparent,
                  );
                }),
                Center(
                  child: SvgPicture.asset(
                    'assets/find_pet/found.svg',
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(() {
          return controller.loadingFindTutor.value
              ? CircularProgressIndicator()
              : CustomButton.filled(
                  action: controller.isEmailValid.value
                      ? () {
                          FocusScope.of(context).unfocus();
                          controller.findTutor();
                        }
                      : null,
                  title: Text(
                    'Continuar',
                    style: AppTextStyles.poppinsSemiBold(
                      color: AppColors.background,
                    ).style,
                  ),
                );
        }),
      ],
    );
  }
}
