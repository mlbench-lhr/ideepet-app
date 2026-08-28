import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class DrawerMenuController extends GetxController {
  final AppStateService appStateService;
  final NavigationService _navigationService;
  final AuthService _authService;

  DrawerMenuController(
      this.appStateService, this._navigationService, this._authService);

  void gotoToEditPersonalData() =>
      _navigationService.toNamed(OnboardingRoutes.onboarding);

  void goToNewAccount() {}

  void goToSettings() {}

  Future<void> logout() async {
    _authService.logout();
  }

  void close() => _navigationService.back();
}
