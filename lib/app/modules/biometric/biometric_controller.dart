import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/core/core_old/handler/handler.dart';
import 'package:idee_pet/app/routes/biometric_routes.dart';
import 'package:permission_handler/permission_handler.dart';

class BiometricController extends GetxController {
  final NavigationService _navigationService;
  final BiometricsRepository _biometricsRepository;
  BiometricController(this._navigationService, this._biometricsRepository);

  late Pet pet;

  @override
  void onInit() {
    super.onInit();
    _requestCamera();
    if (Get.arguments != null && Get.arguments is Pet) {
      pet = Get.arguments as Pet;
    }
  }

  Future<void> _requestCamera() async {
    final cameraPermission = await requestPermission(Permission.camera);
    // final locationPermission = await requestPermission(Permission.location);

    if (!cameraPermission
        // || !locationPermission
        ) {
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
        goToResend();
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

  Future<bool> goToBack() async {
    // Aqui você realiza a navegação ou ação desejada
    _navigationService.offAllNamed(HomeRoutes.home);

    // Retorna true para confirmar a ação de voltar
    return true;
  }

  void goToResend() {
    _navigationService.toNamed('/resend');
  }

  void resetState() {
    biometricImages.clear();
    progressBiometric.value = 0.0;
    textSelectCamera.clear();
    detectedLabel.value = '';
    isReady.value = false;
  }

  void backToBiometricAndReset() {
    resetState();

    _navigationService.offNamed(
      BiometricRoutes.biometric,
      arguments: pet,
    );

    // Garante que a tela já montou antes de pedir câmera
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestCamera();
    });
  }

  Future<void> sendBiometric() async {
    if (biometricImages.length < 3) {
      showError(message: "Dados biométricos incompletos ou inválidos.");
      return;
    }
    debugPrint("Enviando biometria...");
    // Para o stream e libera recursos da câmera ANTES de navegar/enviar
    // (disposeCameraResources já faz isso)

    final request = PetBiometryRequest(
      id: pet.id,
      images: List.from(biometricImages), // Cria cópia
    );

    unawaited(_biometricsRepository.sendBiometry(request).then((response) {
      if (response.success) {
        debugPrint("✅ Biometria enviada com sucesso em background.");
        // Pode mostrar uma notificação local de sucesso se desejar
      } else {
        BugTracking().send(
            'Biometria erro',
            Exception('Biometria erro'),
            StackTrace.current,
            'statusCode: ${json.encode(response.statusCode).toString()} ');
        debugPrint("⚠️ Falha ao enviar biometria em background.");
        // Notificar o usuário que houve falha no processamento posterior
        // Get.snackbar("Erro no Processamento", "Falha ao processar a biometria. Tente novamente mais tarde.");
      }
    }).catchError((error) {
      BugTracking().send('Biometria erro', Exception('Biometria erro'),
          StackTrace.current, 'error: $error'.toString());
      debugPrint("⚠️ Erro crítico ao enviar biometria em background: $error");
      // Get.snackbar("Erro de Envio", "Não foi possível enviar a biometria. Verifique sua conexão.");
    }));
    _navigationService.offAllNamed(HomeRoutes.home, arguments: true);
    showInfo(message: 'Biometria enviada e será processada em breve.');
  }
}
