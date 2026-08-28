import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/routes/find_pet_routes.dart';

class InitialController extends GetxController {
  final NavigationService _navigationService;
  InitialController(this._navigationService);

  void goToLogin() => _navigationService.offAllNamed(LoginRoutes.login);
  void goToOnboarding() =>
      _navigationService.toNamed(OnboardingRoutes.onboarding);

  void goToFindPet() => _navigationService.toNamed(FindPetRoutes.findPet);
}
