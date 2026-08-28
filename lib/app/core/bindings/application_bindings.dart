import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/services/osm_service.dart';

class ApplicationBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put(BugTracking(), permanent: true)
      ..put(AppStateService(), permanent: true)
      ..put(NavigationService(Get.find()))

      ..put(AuthRepository())
      ..put(AuthService(
        Get.find(),
      ))
      ..put(OsmRepository())
      ..put(
        OsmService(
          Get.find(),
        ),
      )
      ..put(
          BottomMenuController(
            Get.find(),
            Get.find(),
          ),
          permanent: true)
      ..put(
          DrawerMenuController(
            Get.find(),
            Get.find(),
            Get.find(),
          ),
          permanent: true);
  }

  Future<void> injectDependencies() async {
    dependencies();
    final tokenStorage = await Get.putAsync<TokenService>(
        () async => TokenService(Get.find()),
        permanent: true);
    await tokenStorage.init();

    await BugTracking().init();
  }
}
