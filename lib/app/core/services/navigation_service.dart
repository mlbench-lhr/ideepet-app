import 'package:get/get.dart';
import 'package:idee_pet/lib.dart';

class NavigationService extends GetxService {
  final AppStateService _appStateService;
  NavigationService(this._appStateService);

  Future<void> toNamed(final String route, {final dynamic arguments}) async {
    _updateBottomBar(route);
    BugTracking().trackNavigation(route);
    await Get.toNamed(route, arguments: arguments);
  }

  Future<void> offNamed(final String route, {final dynamic arguments}) async {
    _updateBottomBar(route);
    BugTracking().trackNavigation(route);
    await Get.offNamed(route, arguments: arguments);
  }

  Future<void> offAllNamed(final String route,
      {final dynamic arguments}) async {
    _updateBottomBar(route);
    BugTracking().trackNavigation(route);
    await Get.offAllNamed(route, arguments: arguments);
  }

  Future<void> back() async {
    _updateBottomBar(Get.currentRoute);
    Get.back();
  }

  void _updateBottomBar(String route) {
    if (!Get.isRegistered<BottomMenuController>()) return;
    final controller = Get.find<BottomMenuController>();
    controller.updateTabIndex(route);
  }

  Future<void> navigate() async {}
}
