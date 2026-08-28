import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/helpers/field.dart';
import 'package:idee_pet/app/modules/find_pet_result/repository/find_pet_result_repository.dart';
import 'package:idee_pet/app/modules/find_pet_result/repository/sent_data_pet.dart';
import 'package:idee_pet/app/modules/find_pet_result/widgets/sucess.dart';

class FindPetResultController extends GetxController {
  final NavigationService _navigationService;
  final FindPetResultRepository _findPetResultRepository;
  FindPetResultController(
      this._navigationService, this._findPetResultRepository);

  late final List<File> images;

  final RxDouble progress = 0.0.obs;
  double latitude = 0;
  double longitude = 0;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map;

    images = (args['images'] as List).cast<File>();
    getCurrentLocation();
    uploadImages();
    loadProfile();
  }

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        showError(
          message: 'Ative o GPS do seu dispositivo',
        );
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).catchError((error) {
        showError(
          message: 'Erro ao obter localização',
        );
      });

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print('Erro: $e');
    }
  }

  Profile? currentUser;

  Future<void> loadProfile() async {
    final auth = Get.find<AuthService>();
    currentUser = await auth.getProfileWithoutRedirect();

    if (currentUser != null) {
      name.controller.text = currentUser!.name;
      phone.controller.text = currentUser!.phone?.substring(3) ?? '';
      email.controller.text = currentUser!.email;
    }
  }

  RxBool loading = false.obs;

  bool? findPet;

  String? petId;
  String? petName;

  Future<void> uploadImages() async {
    loading.value = true;
    progress.value = 0.0;

    final response = await _findPetResultRepository.findPet(images, (value) {
      progress.value = value;
    });
    if (response.success) {
      findPet = response.result!.exists;
      petId = response.result!.petId;
      petName = response.result!.petName; 
    } else {
      findPet = false;
    }

    // findPet = true;
    // petId = '1';

    loading.value = false;
  }

  RxBool loadingSent = false.obs;

  Future<void> sentOnlyLocation() async {
    loadingSent(true);
    final response = await _findPetResultRepository.sendDataPet(SentDataPet(
      email: null,
      name: null,
      phone: null,
      lat: latitude.toString(),
      long: longitude.toString(),
      petId: petId!,
    ));
    if (response.success) {
      goToPetFindSucessLocation();
    }
    loadingSent(false);
  }

  void back() {
    _navigationService.back();
    _navigationService.back();
  }

  final name = ValidatedField(validator: validateName);
  final phone = ValidatedField(validator: validatePhone);
  final email = ValidatedField(validator: (value) {
    if (value.trim().isEmpty) return null;
    return validateEmail(value);
  });

  final RxBool acceptTerms = false.obs;
  final RxString errorTerms = ''.obs;

  void validateAllFields() {
    name.validate();
    phone.validate();
    email.validateIfNotEmpty();
    if (!acceptTerms.value) {
      errorTerms.value = 'Você deve aceitar os termos';
    } else {
      errorTerms.value = '';
    }
  }

  Future<void> sendData() async {
    validateAllFields();

    if (name.error.value.isEmpty &&
        phone.error.value.isEmpty &&
        email.error.value.isEmpty &&
        acceptTerms.value) {
      loadingSent(true);
      final response = await _findPetResultRepository.sendDataPet(SentDataPet(
        email: email.controller.text,
        name: name.controller.text,
        phone: phone.controller.text,
        lat: latitude.toString(),
        long: longitude.toString(),
        petId: petId!,
      ));
      if (response.success) {
        goToPetFindSucessData();
      }
      loadingSent(false);
    }
  }

  void goToPetFindSucessData() => Get.to(() => SucessFindPet(
        containsData: true,
      ));

  void goToPetFindSucessLocation() => Get.to(() => SucessFindPet(
        containsData: false,
      ));
}
