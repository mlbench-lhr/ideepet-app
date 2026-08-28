import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

abstract class BasePage<myController> extends GetView<myController> {
  const BasePage({
    super.key,
    this.showBottomNavigation = true,
  });
  final bool showBottomNavigation;
  final String base = 'assets/base';

  @protected
  Widget body(final BuildContext context);

  @override
  Widget build(final BuildContext context) {
    //final AppStateService appStateService = Get.find();
    return Scaffold(
      //   key: appStateService.scaffoldKey,
      extendBody: true,
      //  drawer: DrawerMenuView(),
      body: !showBottomNavigation
          ? Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 60, bottom: 40),
              child: body(context),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 40),
              child: AppBottomBar(
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: body(context),
                ),
              ),
            ),
    );
  }
}
