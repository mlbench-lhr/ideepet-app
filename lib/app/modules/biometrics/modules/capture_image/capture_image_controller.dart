import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CaptureImageController extends GetxController {
  CameraController? cameraController;
  var isCameraInitialized = false.obs;
  var isTakingPicture = false.obs;

  List<CameraDescription> cameras = [];
  void Function(String imagePath)? _onImageCaptured;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args['onImageCaptured'] is Function) {
      _onImageCaptured = args['onImageCaptured'];
    }

    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        cameraController = CameraController(
          cameras[0],
          ResolutionPreset.max,
          enableAudio: false,
        );
        await cameraController!.initialize();
        isCameraInitialized.value = true;
      }
    } catch (e) {
      debugPrint('Erro ao inicializar a câmera: $e');
    }
  }

  Future<void> captureImage() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      debugPrint('Câmera não está pronta');
      return;
    }

    if (isTakingPicture.value) return;

    try {
      isTakingPicture.value = true;
      final XFile file = await cameraController!.takePicture();
      _onImageCaptured?.call(file.path);
    } catch (e) {
      debugPrint('Erro ao capturar imagem: $e');
    } finally {
      isTakingPicture.value = false;
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
