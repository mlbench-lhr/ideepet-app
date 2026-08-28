import 'package:get/get.dart';
import 'package:idee_pet/app/core/helpers/messages.dart';
import 'package:idee_pet/app/core/services/app_state_service.dart';
import 'package:idee_pet/app/modules/health/modules/vaccine/repository/dtos/dtos.dart';

import 'package:idee_pet/app/modules/health/modules/vaccine/repository/vaccine_repository.dart';

class VaccineController extends GetxController {
  final AppStateService appStateService;
  final VaccineRepository _vaccineRepository;
  // final NavigationService _navigationService;

  VaccineController(
    this.appStateService,
    this._vaccineRepository,
    // this._navigationService,
  );

  final isLoading = false.obs;

  final loadingCreateVaccine = false.obs;

  final vaccines = <VaccineResponse>[].obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    isLoading(true);
    await _getVaccines();
    isLoading(false);
  }

  Future<void> deleteVaccine(VaccineResponse vaccine) async {
    final request = DeleteVaccineRequest(vaccine.id);
    final response = await _vaccineRepository.deleteVaccines(request);
    if (response.success) {
      showSuccess(message: 'Vacina apagada!');
      _getVaccines();
    }
  }

  Future<void> _getVaccines() async {
    final request = VaccineRequest(appStateService.pet().id);
    final response = await _vaccineRepository.getVaccines(request);
    if (response.result != null && response.success) {
      vaccines(response.result);
      return;
    }
    showError(message: 'Erro ao receber as vacinas');
  }

  Future<void> createVaccine(CreateVaccineRequest request) async {
    loadingCreateVaccine(true);
    final response = await _vaccineRepository.createVaccine(request);
    if (response.success) {
      _getVaccines();

      showSuccess(message: 'Vacina criada com sucesso!');
    } else {
      showError(message: 'Erro ao criar vacina');
    }
    loadingCreateVaccine(false);
  }

  Future<void> editVaccine(EditVaccineRequest request) async {
    loadingCreateVaccine(true);
    final response = await _vaccineRepository.editVaccine(request);
    if (response.success) {
      _getVaccines();

      showSuccess(message: 'Vacina:${request.title} editada!');
      loadingCreateVaccine(false);
    } else {
      showError(message: 'Erro ao editar vacina');
    }
    loadingCreateVaccine(false);
  }
  // Future<void> setSelectedPlan(HealthPlanResponse plan) async {
  //   final request = UpdateHealthPlanRequest(appStateService.pet().id, plan.id);
  //   final response = await _healthPlansRepository.updateHealthPlan(request);
  //   if (response.result != null && response.success) {
  //     appStateService.pet().healthPlanId = plan.id;
  //     _navigationService.back();
  //     showSuccess(message: 'Plano de saúde selecionado com sucesso');
  //     return;
  //   }
  //   showError(message: 'Erro ao selecionar plano de saúde');
  // }

  //void back() => _navigationService.back();
}
