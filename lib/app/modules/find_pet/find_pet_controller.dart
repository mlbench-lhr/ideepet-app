import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/core_old/handler/handler.dart';
import 'package:permission_handler/permission_handler.dart';

class FindPetController extends GetxController {
  final NavigationService _navigationService;
  FindPetController(this._navigationService);

  @override
  void onInit() {
    super.onInit();
    _requestCamera();
  }

  Future<void> _requestCamera() async {
    final cameraPermission = await requestPermission(Permission.camera);
    final locationPermission = await requestPermission(Permission.location);

    if (!cameraPermission || !locationPermission) {
      Get.back();
      showError(message: 'A permissão de câmera é obrigatória para continuar');
    } else {
      isReady(true);
    }
  }

  final isReady = false.obs;
  final biometricImages = <File>[].obs;
  var progressBiometric = 0.0.obs;
  final textSelectCamera = <String>[].obs;
  var detectedLabel = ''.obs;

  Future<void> captureAndStoreImage(XFile file) async {
    setProgressBiometric();

    try {
      if (biometricImages.length < 3) {
        // Adiciona a imagem capturada à lista
        biometricImages.add(File(file.path));
        setProgressBiometric(); // Atualiza UI
      } else {
        showError(message: "Máximo de 3 imagens atingido.");
        return;
      }
    } catch (e) {
      showError(message: "Erro ao capturar imagem: $e");

      biometricImages.clear();
      setProgressBiometric();
    }
  }

  void setProgressBiometric() {
    final count = biometricImages.length;
    final texts = [
      'BioPetScan™ Capturando padrões únicos com tecnologia multiespectral.',
      'QuantumPet Analysis™ Explorando detalhes com precisão quântica.',
      'PetNeural ID Verification™ Análise para autenticação precisa.',
      'PetCrypto Vault™ Armazenamento seguro com criptografia.'
    ];

    // Atualiza o valor do progresso
    progressBiometric(count / 3.0);

    // Atualiza os textos visíveis
    textSelectCamera.assignAll(texts
        .take(count + 1)
        .toList()
        .sublist(count > 0 ? count - 1 : 0, count + 1)); // Mostra 1 ou 2 textos
    // Lógica alternativa para mostrar textos:
    // textSelectCamera.clear();
    // if (count < texts.length) textSelectCamera.add(texts[count]);

    // Avança automaticamente após a terceira foto
    if (count >= 3) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        goToFindPetResult();
      });
    }
  }

  void onResult(List<Recognition> results) {
    // Atualiza a label detectada
    if (results.isNotEmpty) {
      detectedLabel.value = results[0].label;
    } else {
      detectedLabel.value = '';
    }
  }

  void goToBack() => _navigationService.back();

  void goToFindPetResult() {
    _navigationService.toNamed('/find-pet-result', arguments: {
      'images': List.from(biometricImages),
    });
  }
}
