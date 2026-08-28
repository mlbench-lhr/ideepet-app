import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class MedicalRecordController extends GetxController {
  final AppStateService appStateService;
  final NavigationService _navigationService;
  final MedicalRecordRepository _medicalRecordRepository;

  MedicalRecordController(
    this.appStateService,
    this._navigationService,
    this._medicalRecordRepository,
  );

  final list = <MedicalRecordResponse>[].obs;
  final isLoading = false.obs;

  @override
  Future<void> onReady() async {
    isLoading(true);
    await _getMedicalRecord();
    isLoading(false);
    super.onReady();
  }

  Future<void> _getMedicalRecord() async {
    final request = GetMedicalRecordRequest(appStateService.pet().id);
    final response = await _medicalRecordRepository.getMedicalRecord(request);
    if (response.result != null && response.success) {
      list(response.result);
      return;
    }
    showError(message: response.errorMessages?.first ?? 'Algo deu errado');
  }

  Future<void> createMedicalRecord(CreateMedicalRecordRequest request) async {
    isLoading(true);
    final response =
        await _medicalRecordRepository.createMedicalRecord(request);

    if (response.success) {
      showSuccess(message: 'Registro criado com sucesso');
      await _getMedicalRecord();
      isLoading(false);
      return;
    }
    isLoading(false);
    showError(message: response.errorMessages?.first ?? 'Algo deu errado');
  }

  Future<void> deleteMedicalRecord(String id) async {
    final response = await _medicalRecordRepository.deleteMedicalRecord(id);
    if (response.success) {
      list.removeWhere((element) => element.id == id);
      return;
    }
    showError(message: response.errorMessages?.first ?? 'Algo deu errado');
  }
}
