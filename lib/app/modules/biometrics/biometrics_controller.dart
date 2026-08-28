import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/routes/capture_image_routes.dart';
import 'package:image_picker/image_picker.dart';

class BiometricsController extends GetxController {
  final BiometricsRepository _biometricsRepository;
  final NavigationService _navigationService;
  final AppStateService appStateService;

  BiometricsController(
    this._biometricsRepository,
    this._navigationService,
    this.appStateService,
  );

  Future<void> goToCaptureImage({
    required void Function(String imagePath) onImageCaptured,
  }) async {
    await _navigationService.toNamed(
      CaptureImageRoutes.captureImage,
      arguments: {
        'onImageCaptured': onImageCaptured,
      },
    );
  }

  late Pet pet;

  // --- PageView Logic ---
  final PageController pageController = PageController();
  final currentPage = 0.obs;

  // --- Pet Profile Picture Logic ---
  var petProfile = Rx<File?>(null);
  var loadingPetProfile = false.obs;
  var progress = 0.0.obs;

  var detectedLabel = ''.obs;

  RxDouble progressPetProfile = 0.0.obs;

  void setProgressPetProfile(double value) => progressPetProfile.value = value;

  // Biometric capture related variables
  final biometricImages = <File>[].obs;
  var progressBiometric = 0.0.obs;
  final textSelectCamera = <String>[].obs;
  final isReady = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Pet) {
      pet = Get.arguments as Pet;
    } else {
      // Lidar com erro se Pet não for passado corretamente
      print("Erro: Pet não recebido nos argumentos.");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showError(message: 'Pet não encontrado. Retornando.');
        _navigationService.offAllNamed(HomeRoutes.home);
      });
    }
    isReady(true);
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    // await initializeCameraAndModel();
  }

  @override
  void onClose() {
    // disposeCameraResources();
    super.onClose();
  }

  // ===========================================================================
  // Lógica do PageView
  // ===========================================================================

  void setCurrentPage(int value) => currentPage(value);

  void nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previosPage() {
    pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // ===========================================================================
  // Lógica da Foto de Perfil do Pet
  // ===========================================================================

  Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();

    try {
      final pickedFile =
          await picker.pickImage(source: source, imageQuality: 80);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      print("Erro ao selecionar imagem: $e");
      showError(
          message:
              "Não foi possível acessar a ${source == ImageSource.camera ? 'câmera' : 'galeria'}. Verifique as permissões.");
    }
    return null;
  }

  void updatePetProfile(File? image) {
    if (image != null) {
      petProfile.value = image;
    }
  }

  void setLoadingPetProfile(bool value) => loadingPetProfile.value = value;
  void attProgress(double value) => progress.value = value;

  Future<void> sendPetProfile() async {
    if (petProfile.value == null) {
      showError(message: "Selecione uma imagem de perfil.");
      return;
    }

    setLoadingPetProfile(true);
    progress(0.0);

    final request = PetProfileRequest(
      id: pet.id,
      image: petProfile.value!,
      onProgress: setProgressPetProfile,
    );

    try {
      final response = await _biometricsRepository.sendPetProfile(request);

      if (response.success) {
        nextPage();
      } else {
        showError(message: 'Erro ao enviar a foto do pet');
      }
    } catch (e) {
      print("Erro em sendPetProfile: $e");
      showError(message: 'Ocorreu um erro ao enviar a foto.');
    } finally {
      setLoadingPetProfile(false);
      progress(0.0); // Reseta progresso
    }
  }

  // ===========================================================================
  // Lógica de Captura de Biometria
  // ===========================================================================
  void onResult(List<Recognition> results) {
    // Atualiza a label detectada
    if (results.isNotEmpty) {
      detectedLabel.value = results[0].label;
    } else {
      detectedLabel.value = '';
    }
  }

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

  // Atualiza o progresso e os textos exibidos
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
        avanceToSent();
      });
    }
  }

  // Navega para envio após pequena pausa
  void avanceToSent() {
    Future.delayed(Duration(milliseconds: 500), () {
      if (biometricImages.length >= 3) {
        sendPetBiometrics();
      }
    });
  }

  // Envia as imagens e navega
  Future<void> sendPetBiometrics() async {
    // Garante que temos as imagens e o pet
    if (biometricImages.length < 3) {
      showError(message: "Dados biométricos incompletos ou inválidos.");
      return;
    }

    print("Enviando biometria...");
    // Para o stream e libera recursos da câmera ANTES de navegar/enviar
    // (disposeCameraResources já faz isso)

    final request = PetBiometryRequest(
      id: pet.id,
      images: List.from(biometricImages), // Cria cópia
    );

    // Mostra um loading ou status de envio na próxima tela
    // Não espera o resultado aqui, navega imediatamente
    unawaited(_biometricsRepository.sendBiometry(request).then((response) {
      if (response.success) {
        print("✅ Biometria enviada com sucesso em background.");
        // Pode mostrar uma notificação local de sucesso se desejar
      } else {
        BugTracking().send(
            'Biometria erro',
            Exception('Biometria erro'),
            StackTrace.current,
            'statusCode: ${json.encode(response.statusCode).toString()} ');
        print("⚠️ Falha ao enviar biometria em background.");
        // Notificar o usuário que houve falha no processamento posterior
        // Get.snackbar("Erro no Processamento", "Falha ao processar a biometria. Tente novamente mais tarde.");
      }
    }).catchError((error) {
      BugTracking().send('Biometria erro', Exception('Biometria erro'),
          StackTrace.current, 'error: $error'.toString());
      print("⚠️ Erro crítico ao enviar biometria em background: $error");
      // Get.snackbar("Erro de Envio", "Não foi possível enviar a biometria. Verifique sua conexão.");
    }));

    // Navega para home informando que está processando
    _navigationService.offAllNamed(HomeRoutes.home, arguments: true);
    showInfo(message: 'Biometria enviada e será processada em breve.');
  }

  // ===========================================================================
  // Navegação
  // ===========================================================================
  void goToNewPet() => _navigationService.offAllNamed(NewPetRoutes.newPet);
  void goToHome({bool? processing}) =>
      _navigationService.offAllNamed(HomeRoutes.home,
          arguments: {'processing': processing ?? false});
}
