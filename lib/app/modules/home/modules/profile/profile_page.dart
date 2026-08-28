import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class ProfilePage extends BasePage<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget body(BuildContext context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
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
                Text('Cadastro Geral',
                    style: AppTextStyles.title(fontSize: 18).style),
                const SizedBox(height: 18),
                Obx(() {
                  return GeneralCard(
                    petId: controller.appStateService.pet().id,
                    petName: controller.appStateService.profile().name,
                    avatarUrl: controller.appStateService.profile().imageUrl,
                    phone: controller.appStateService.profile().phone,
                    onTap: controller.gotoEditPersonalInfoPhoto,
                  );
                }),
                const SizedBox(height: 6),
                ButtonHealth(
                  svgPath: 'assets/account_general/info.svg',
                  title: 'Informações pessoais',
                  action: controller.gotoEditPersonalInfo,
                ),
                // const SizedBox(height: 6),
                // ButtonHealth(
                //   svgPath: 'assets/account_general/config.svg',
                //   title: 'Configurações de perfil',
                //   action: () {},
                // ),
                const SizedBox(height: 6),
                ButtonHealth(
                  iconData: Icons.logout,
                  // color: AppColors.errorColor,
                  title: 'Sair',
                  action: controller.logout,
                ),
                const SizedBox(height: 6),
                Obx(() {
                  return controller.loadingDeleteAccount.value
                      ? Center(
                          child: CircularProgressIndicator(
                              backgroundColor: AppColors.primary))
                      : ButtonHealth(
                          iconData: Icons.delete,
                          color: AppColors.errorColor,
                          title: 'Excluir Conta',
                          action: () {
                            DialogApp.showOkCancelDialog(
                                context,
                                'Excluir Conta',
                                'Tem certeza que deseja excluir sua conta?',
                                () => controller.deleteAccount(),
                                background: AppColors.errorColor,
                                dialogType: DialogType.error,
                                subtitleTextStyle:
                                    TextStyle(color: AppColors.greyWhite),
                                titleTextStyle:
                                    TextStyle(color: AppColors.greyWhite),
                                btnOkText: 'Sim, excluir',
                                bttnOkColor: Colors.red);
                          },
                        );
                }),
                const SizedBox(height: 6),
              ],
            ),
            Obx(
              () => controller.loadingMap.isTrue
                  ? Center(child: CircularProgressIndicator())
                  : ProfileMap(
                      controller: controller.mapController(),
                    ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      );
}
