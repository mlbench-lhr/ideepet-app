import 'package:get/get.dart';
import 'package:idee_pet/app/core/core_old/helps/validate_textfield.dart';
import 'package:idee_pet/app/core/helpers/field.dart';
import 'package:idee_pet/app/modules/transfer_pet/enums/flow_step.dart';
import 'package:idee_pet/app/modules/transfer_pet/repository/dtos/request/find_tutor_request.dart';
import 'package:idee_pet/app/modules/transfer_pet/repository/dtos/response/find_tutor_response.dart';
import 'package:idee_pet/app/modules/transfer_pet/repository/transfer_pet_repository.dart';

class TransferPetController extends GetxController {
  final TransferPetRepository _repository;
  TransferPetController(this._repository);
  final step = TransferPetFlow.initial.obs;

  void onTrueResult() => step.value = TransferPetFlow.success;
  void onFalseResult() => step.value = TransferPetFlow.error;
  void retry() => step.value = TransferPetFlow.initial;
  void confirm() => step.value = TransferPetFlow.confirmed;

  void goBack() => Get.back();

  final email = ValidatedField(validator: (value) {
    if (value.trim().isEmpty) return null;
    return validateEmail(value);
  });

  final RxBool isEmailValid = false.obs;

  void _validateEmail() {
    email.validate();

    isEmailValid.value =
        email.error.value.isEmpty && email.controller.text.isNotEmpty;
  }

  @override
  void onInit() {
    super.onInit();

    email.controller.addListener(_validateEmail);
  }

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }

  RxBool loadingFindTutor = false.obs;

  Future<void> findTutor() async {
    if (isEmailValid.value == false) return;
    loadingFindTutor.value = true;
    await Future.delayed(Duration(seconds: 2));
    final response = await _repository
        .findTutor(FindTutorRequest(email: email.controller.text));

    if (response.success) {
      tutor = response.result;
      step.value = TransferPetFlow.success;
    } else {
      step.value = TransferPetFlow.error;
    }
    loadingFindTutor.value = false;
  }

  FindTutorResponse? tutor;
}
