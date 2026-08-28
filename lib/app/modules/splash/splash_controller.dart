import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class SplashController extends GetxController {
  final TokenService _tokenService;
  final NavigationService _navigationService;
  final HomeRepository _homeRepository;
  String? _token;

  SplashController(
    this._tokenService,
    this._navigationService,
    this._homeRepository,
  );

  final loadingSignIn = false.obs;

  @override
  Future<void> onReady() async {
    _token = await _getToken();
    animation();
    super.onReady();
  }

  Future<String?> _getToken() async {
    return _tokenService.getToken();
  }

  Future<void> _next() async {
    final havePet = await _checkHavePet();

    _navigationService.offNamed(_token != null
        ? havePet
            ? HomeRoutes.home
            : NewPetRoutes.newPet
        : InitialRoutes.initial);
    // if (_token != null) {
    //   showSuccess(message: 'Bem-vindo de volta!');
    // }
  }

  Future<bool> _checkHavePet() async {
    final response = await _homeRepository.getPets();
    if (response.result != null) {
      return response.result!.isNotEmpty;
    }
    return false;
  }

  final iconLogoOpacity = false.obs;

  void iconLogoOpacityGo() {
    iconLogoOpacity(true);
  }

  bool _iconLogoAnimation = false;

  void iconLogoAnimationGo() {
    _iconLogoAnimation = true;
  }

  bool get iconLogoAnimation => _iconLogoAnimation;

  final iconNameAnimation = false.obs;

  void iconNameAnimationGo() {
    iconNameAnimation(true);
  }

  Future<void> animation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    iconLogoOpacityGo();
    await Future.delayed(const Duration(milliseconds: 500));
    iconLogoAnimationGo();
    await Future.delayed(const Duration(milliseconds: 500));
    iconNameAnimationGo();
    await Future.delayed(const Duration(milliseconds: 500));

    _next();
  }

  final permissionsDenied = false.obs;

  void permissionsDeniedShow(bool value) {
    permissionsDenied(value);
  }
}
