import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class HealthConditionController extends GetxController {
  final HealthConditionRepository _healthConditionRepository;
  final AppStateService appStateService;

  final conditionTextController = TextEditingController().obs;
  final conditionDateController = TextEditingController().obs;
  final conditionSeverityController = TextEditingController().obs;

  HealthConditionController(
    this._healthConditionRepository,
    this.appStateService,
  );

  final canContinue = false.obs;
  final isLoading = false.obs;
  final severityList = <String>[].obs;
  final selectedSeverity = 'Não grave'.obs;
  final selectedDate = DateTime.now().obs;

  final loadingDate = false.obs;

  String _originalText = '';
  String _originalDate = '';
  String _originalSeverity = '';

  @override
  Future<void> onReady() async {
    super.onReady();
    isLoading(true);

    await _getDate();
    _getSeverityList();
    _getSeverity();
    conditionTextController().text =
        appStateService.pet().healthConditionValue ?? '';

    _originalText = conditionTextController().text;
    _originalDate = conditionDateController().text;
    _originalSeverity = conditionSeverityController().text;

    // 3. Adiciona os ouvintes
    conditionTextController().addListener(validate);
    conditionDateController().addListener(validate);
    conditionSeverityController().addListener(validate);

    isLoading(false);
    validate(); // Vai dar false, porque nada mudou em relação ao que acabou de ser definido
  }

  void _getSeverityList() {
    severityList(SeverityHealthEnum.values
        .map((severity) => severityHealthToString(severity))
        .toList());
  }

  void _getSeverity() {
    selectedSeverity(
      severityHealthToString(
        parseSeverityHealth(appStateService.pet().healthSeverity),
      ),
    );
  }

  Future<void> _getDate() async {
    loadingDate(true);
    await Future.delayed(Duration(seconds: 1));

    if (appStateService.pet().healthDate != '') {
      try {
        final date = DateTime.parse(appStateService.pet().healthDate);
        setDate(date);
      } catch (e) {
        selectedDate(DateTime.now());
      }

      loadingDate(false);
      return;
    }
    loadingDate(false);
    selectedDate(DateTime.now());
  }

  bool validate() {
    final currentText = conditionTextController().text.trim();
    final currentDate = conditionDateController().text.trim();
    final currentSeverity = conditionSeverityController().text.trim();
    final isNotEmpty = currentText.isNotEmpty;

    final hasChanged = currentText != _originalText ||
        currentDate != _originalDate ||
        currentSeverity != _originalSeverity;

    final result = isNotEmpty && hasChanged;

    canContinue(result);
    return result;
  }

  void setDate(DateTime date) {
    selectedDate(date);
    conditionDateController().text = date.toString();
    validate();
  }

  void setSeverity(String severity) {
    conditionSeverityController().text = severity;
  }

  void save() => validate()
      ? _updateData()
      : showError(message: 'Preencha todos os campos!');

  Future<void> _updateData() async {
    isLoading(true);
    final request = UpdateHealthConditionRequest(
      conditionTextController().text,
      severityHealthFromString(conditionSeverityController().text).name,
      selectedDate(),
    );
    final response = await _healthConditionRepository.updateHeathCondition(
        request, appStateService.pet().id);
    isLoading(false);
    if (response.success && response.result != null) {
      appStateService.pet(response.result);

      Get.back();
      showSuccess(message: 'Atualizado com sucesso!');
      return;
    }
    showError(message: response.errorMessages.first ?? 'Erro ao atualizar!');
  }
}
