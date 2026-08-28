import 'package:flutter/material.dart';

import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/menu/widgets/club_dialog.dart';

class AppBottomBar extends GetView<BottomMenuController> {
  const AppBottomBar({super.key, required this.body});

  final Widget body;

  final String base = 'assets/base';

  @override
  Widget build(BuildContext context) {
    Widget _bottomBarItem(
      String svgActive,
      String svgInative,
      String label,
      int? index, {
      VoidCallback? onTap,
    }) {
      return Obx(
        () {
          bool isSelected =
              controller.appStateService.activePageIndex() == index;
          return GestureDetector(
            onTap: () {
              if (index != null) {
                controller.changeTabIndex(index);
              } else {
                onTap!();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    isSelected ? svgActive : svgInative,
                    width: 20,
                    height: 20,
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: isSelected ? 6 : 0,
                  ),
                  Text(label,
                      style: AppTextStyles.poppinsMedium(fontSize: 10).style),
                ],
              ),
            ),
          );
        },
      );
    }

    Widget _bottomUserItem(String label, int index) {
      return Obx(
        () {
          bool isSelected =
              controller.appStateService.activePageIndex() == index;
          return GestureDetector(
            onTap: () => controller.changeTabIndex(index),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularImageWidget(
                    imageUrl: controller.appStateService.pet().avatarUrl,
                    size: isSelected ? 26 : 22,
                    borderColor: AppColors.primary,
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: isSelected ? 6 : 0,
                  ),
                  Text(label,
                      style: AppTextStyles.poppinsMedium(fontSize: 10).style),
                ],
              ),
            ),
          );
        },
      );
    }

    return BottomBar(
      fit: StackFit.expand,
      showIcon: false,
      width: MediaQuery.of(context).size.width * 0.9,
      barAlignment: Alignment.bottomCenter,
      borderRadius: BorderRadius.circular(20),
      hideOnScroll: false,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      offset: 15,
      barColor: AppColors.background,
      barDecoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _bottomBarItem(
              '$base/home_ative.svg',
              '$base/home_inactive.svg',
              "Home",
              0,
            ),
            _bottomBarItem(
              '$base/heart_ative.svg',
              '$base/heart_inactive.svg',
              "Saúde",
              1,
            ),
            // _bottomBarItem(
            //   '$base/bell_ative.svg',
            //   '$base/bell_inactive.svg',
            //   "Notificações",
            //   2,
            // ),
            _bottomBarItem(
              '$base/find_pet.svg',
              '$base/find_pet.svg',
              "Encontrar Pet",
              null,
              onTap: () => controller.goToFindPet(),
            ),
            _bottomBarItem(
              '$base/percent_ative.svg',
              '$base/percent_inactive.svg',
              "Clube",
              null,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => ClubDialogWidget(),
                );
              },
            ),
            // _bottomUserItem(
            //   "Perfil",
            //   3,
            // ),
          ],
        ),
      ),
      body: (context, controller) => body,
    );
  }
}
