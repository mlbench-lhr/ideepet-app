import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class HealthPlansController extends GetxController {
  final AppStateService appStateService;
  final HealthPlansRepository _healthPlansRepository;
  final NavigationService _navigationService;

  HealthPlansController(
    this.appStateService,
    this._healthPlansRepository,
    this._navigationService,
  );

  final isLoading = false.obs;
  final healthPlans = <HealthPlanResponse>[].obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    isLoading(true);
    await _getHealthPlans();
    isLoading(false);
  }

  Future<void> _getHealthPlans() async {
    final response = await _healthPlansRepository.getHealthPlans();
    if (response.result != null && response.success) {
      healthPlans(response.result);
    }
  }

  Future<void> setSelectedPlan(HealthPlanResponse plan) async {
    isLoading(true);
    final request = UpdateHealthPlanRequest(appStateService.pet().id, plan.id);
    final response = await _healthPlansRepository.updateHealthPlan(request);
    isLoading(false);

    if (response.result != null && response.success) {
      appStateService.pet().healthPlanId = plan.id;
      _navigationService.back();
      showSuccess(message: 'Plano de saúde selecionado com sucesso');
      return;
    }
    showError(message: 'Erro ao selecionar plano de saúde');
  }

  void back() => _navigationService.back();
}
