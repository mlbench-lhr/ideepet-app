import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class NewPasswordSuccessController extends GetxController {
  final NavigationService _navigationService;
  NewPasswordSuccessController(this._navigationService);

  void goToLogin() => _navigationService.offAllNamed(LoginRoutes.login);
}
