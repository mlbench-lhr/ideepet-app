import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/svgs.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class DrawerMenuView extends GetView<DrawerMenuController> {
  const DrawerMenuView({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CustomLogo.logoIcon(
                  height: 24,
                  width: 24,
                ),
                trailing: IconButton(
                    onPressed: controller.close, icon: Icon(Icons.close)),
                title: Text(
                    'Olá, ${controller.appStateService.profile().firstName()}!',
                    style: AppTextStyles.title(fontSize: 18).style),
              ),
              SizedBox(height: 20),
              AppDivider(),
              SizedBox(height: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _menuItem('Edição e cadastro do tutor',
                        controller.gotoToEditPersonalData),
                    SizedBox(height: 10),
                    _menuItem('Criar nova conta', controller.goToNewAccount),
                    SizedBox(height: 10),
                    _menuItem('Configurações', controller.goToSettings),
                    SizedBox(height: 20),
                    AppDivider(),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: controller.logout,
                      child: Text(
                        'Sair',
                        style: AppTextStyles.montserratSemiBold(
                                color: Color(0xFF808693))
                            .style,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Versão: ${controller.appStateService.appVersion()}+${controller.appStateService.appBuildNumber()}',
                      style: AppTextStyles.montserratSemiBold(
                              color: AppColors.textfield)
                          .style,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget _menuItem(String title, VoidCallback action) => GestureDetector(
        onTap: action,
        child: Text(
          title,
          style: AppTextStyles.poppinsMedium().style,
        ),
      );
}
