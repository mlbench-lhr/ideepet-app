import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class HealthController extends GetxController {
  final AppStateService appStateService;
  final NavigationService _navigationService;

  HealthController(this.appStateService, this._navigationService);

  final isLoading = false.obs;

  void goToPlans() => _navigationService.toNamed(HealthRoutes.healthPlans);
  void goToVaccines() => _navigationService.toNamed(HealthRoutes.vaccine);
  void goToMedicaments() => _navigationService.toNamed(HealthRoutes.medicament);
  void goToCondition() =>
      _navigationService.toNamed(HealthRoutes.healthCondition);
  void goToMedicalRecors() =>
      _navigationService.toNamed(HealthRoutes.medicalRecord);
}
