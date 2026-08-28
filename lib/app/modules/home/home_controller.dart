import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class HomeController extends GetxController {
  final AuthService _authService;
  final HomeRepository _repository;
  final AppStateService appStateService;
  final NavigationService _navigationService;

  HomeController(
    this._authService,
    this._repository,
    this.appStateService,
    this._navigationService,
  );

  final isLoading = false.obs;
  late final bool reload;

  void goToBiometry() => _navigationService.toNamed(BiometricsRoutes.biometrics,
      arguments: appStateService.pet());

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is bool) {
      reload = Get.arguments;
    } else {
      reload = false;
    }
    getIntNotifications();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    isLoading(true);
    if (appStateService.pets.isEmpty || reload) {
      await Future.wait([_getProfile(), _getPets()]);
    }
    if (appStateService.pets.isEmpty) {
      await Get.offAllNamed(NewPetRoutes.newPet);
    }
    isLoading(false);
  }

  Future<void> _getPets() async {
    final response = await _repository.getPets();
    if (response.result != null) {
      appStateService.pets(response.result);
      if (appStateService.pets.isNotEmpty) {
        setPet(response.result!.first);
      }
    }
  }

  Future<void> _getProfile() async {
    final response = await _authService.getProfile();
    if (response != null) {
      appStateService.profile(response);
      BugTracking().identify(response);
    }
  }

  void setPet(Pet newPet) {
    appStateService.setPet(newPet);
  }

  void setProfile(Profile newProfile) {
    appStateService.setProfile(newProfile);
  }

  void goToHealth() {
    _navigationService.offAllNamed(HealthRoutes.health);
  }

  void openDrawer() {
    appStateService.scaffoldKey.currentState?.openDrawer();
  }

  void goToOnboardingCreatePet() {
    _navigationService
      ..back()
      ..toNamed(NewPetRoutes.newPet);
  }

  void goToEditFoodPet() {
    _navigationService.toNamed(EditPetRoutes.editFood,
        arguments: appStateService.pet());
  }

  void goToPersonality() {
    _navigationService.toNamed(EditPetRoutes.editPersonality,
        arguments: appStateService.pet());
  }

  void goToHealthDetails() {
    _navigationService.toNamed(HealthRoutes.healthCondition);
  }

  void goToEditDetails() {
    _navigationService.toNamed(EditPetRoutes.editDetails,
        arguments: appStateService.pet());
  }

  void goToEditSize() {
    _navigationService.toNamed(EditPetRoutes.editSize,
        arguments: appStateService.pet());
  }

  Future<void> goToNotifications() async {
    await _navigationService.toNamed(NotificationsRoutes.notifications);
  }

  void goToProfile() {
    _navigationService.toNamed(HomeRoutes.profile);
  }

  RxInt notifications = 0.obs;

  void getIntNotifications() async {
    final response = await _repository.getIntNotifications();

    if (response.result != null) {
      notifications.value = response.result!;
    } else {
      showError(message: response.errorMessages?.first ?? 'Algo deu errado');
    }
  }
}
