import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class MedicamentController extends GetxController {
  final AppStateService appStateService;
  final MedicamentRepository _medicamentRepository;
  // final NavigationService _navigationService;

  MedicamentController(
    this.appStateService,
    this._medicamentRepository,
    // this._navigationService,
  );

  final isLoading = false.obs;

  final loadingCreateMedicament = false.obs;

  final medicaments = <MedicamentResponse>[].obs;

  final processingCreate = false.obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    isLoading(true);
    await _getMedicaments();
    isLoading(false);
  }

  Future<void> deleteMedicament(MedicamentResponse medicament) async {
    final request = DeleteMedicamentRequest(medicament.id);
    final response = await _medicamentRepository.deleteMedicaments(request);
    if (response.success) {
      showSuccess(message: 'Medicamento apagado!');
      _getMedicaments();
    }
  }

  Future<void> _getMedicaments() async {
    final request = MedicamentRequest(appStateService.pet().id);
    final response = await _medicamentRepository.getMedicaments(request);
    if (response.result != null && response.success) {
      medicaments(response.result);
      return;
    }
    showError(message: 'Erro ao receber as medicamentos');
  }

  Future<void> createMedicament(CreateMedicamentRequest request) async {
    processingCreate(true);
    final response = await _medicamentRepository.createMedicament(request);
    if (response.success) {
      await _getMedicaments();

      showSuccess(message: 'Medicamento criado com sucesso!');
      loadingCreateMedicament(false);
    }
    processingCreate(false);
  }
}
