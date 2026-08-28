import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:flutter/foundation.dart'; // Para kIsWeb e debugPrint

// Importante: As funções de conversão YUV/BGRA precisam estar corretas.
// Considere usar o pacote 'image' se as suas não funcionarem 100%.

class RealtimeDetectionController extends GetxController {
  // --- Câmera ---
  CameraController? cameraController;
  List<CameraDescription>? _cameras;
  final RxBool isCameraInitialized = false.obs;
  final RxString cameraErrorMessage = ''.obs; // Para erros de câmera

  // --- TFLite ---
  tfl.Interpreter? _interpreter;
  List<String>? _labels;
  bool _isModelLoaded = false; // Estado interno
  final RxString modelErrorMessage = ''.obs; // Para erros de modelo

  // --- Detecção ---
  final RxBool isDetecting = false.obs; // Lock para processamento
  final RxString detectedLabel = ''.obs; // Resultado final
  final RxDouble confidence = 0.0.obs; // Confiança da detecção
  final RxString processingError =
      ''.obs; // Erros durante processamento/inferência

  // --- Otimização ---
  DateTime? _lastProcessedFrameTime;
  final Duration _processInterval =
      const Duration(milliseconds: 300); // Intervalo

  // --- Configs (Ajuste) ---
  final String modelPath =
      'assets/tflite/mobilenet_v1_1.0_224.tflite'; // SEU MODELO FLOAT
  final String labelsPath = 'assets/tflite/labels.txt';
  final double confidenceThreshold =
      0.8; // Limiar (0.0 a 1.0 para float -1 a 1, ajuste!)

  @override
  void onInit() {
    super.onInit();
    print("RealtimeDetectionController: onInit");
    // Inicializa automaticamente ao criar o controller
    initializeCameraAndModel();
  }

  @override
  void onClose() {
    print("RealtimeDetectionController: onClose - Cleaning up resources...");
    disposeResources(); // Limpeza Essencial
    super.onClose();
  }

  // ===========================================================================
  // Inicialização
  // ===========================================================================

  Future<void> initializeCameraAndModel() async {
    print("RealtimeDetectionController: Iniciando inicialização...");
    isCameraInitialized.value = false;
    _isModelLoaded = false;
    cameraErrorMessage.value = '';
    modelErrorMessage.value = '';
    processingError.value = ''; // Limpa erros anteriores

    // Garante que recursos antigos sejam liberados antes de tentar de novo
    await disposeResources();

    try {
      // 1. Carregar Modelo TFLite
      await _loadModel();
      if (!_isModelLoaded)
        throw Exception("Modelo TFLite não pôde ser carregado.");

      // 2. Inicializar Câmera
      print("RealtimeDetectionController: Procurando câmeras...");
      try {
        if (_cameras == null || _cameras!.isEmpty) {
          _cameras = await availableCameras();
        }
      } catch (e) {
        throw Exception("Não foi possível obter câmeras: ${e.toString()}");
      }

      if (_cameras == null || _cameras!.isEmpty) {
        throw Exception("Nenhuma câmera encontrada.");
      }
      print(
          "RealtimeDetectionController: Câmeras encontradas: ${_cameras!.length}");

      CameraDescription selectedCamera = _cameras!.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back,
          orElse: () => _cameras!.first);
      print(
          "RealtimeDetectionController: Usando câmera ${selectedCamera.name}");

      cameraController = CameraController(
        selectedCamera,
        ResolutionPreset.medium, // Comece com medium para performance
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.yuv420
            : ImageFormatGroup.bgra8888,
      );

      await cameraController!.initialize();

      // Verifica se o controller ainda existe (evita erro se dispose foi chamado)
      if (cameraController == null)
        throw Exception("CameraController foi descartado durante init.");

      print("RealtimeDetectionController: CameraController inicializado.");
      isCameraInitialized.value = true;
      print("✅ RealtimeDetectionController: Câmera e Modelo prontos.");

      // Inicia o stream de detecção
      startDetection();
    } catch (e, s) {
      print("❌ RealtimeDetectionController: Erro na inicialização: $e\n$s");
      final errorMsg = "Erro ao iniciar detecção: ${e.toString()}";
      cameraErrorMessage.value = errorMsg; // Mostra erro na UI
      isCameraInitialized.value = false;
      await disposeResources(); // Limpa tudo em caso de falha
    }
  }

  Future<void> _loadModel() async {
    if (_isModelLoaded) return;
    modelErrorMessage.value = ''; // Limpa erro anterior
    print("RealtimeDetectionController: Carregando modelo $modelPath");
    try {
      _interpreter = await tfl.Interpreter.fromAsset(modelPath);
      _interpreter!.allocateTensors(); // Aloca tensores

      final labelsData = await rootBundle.loadString(labelsPath);
      _labels = labelsData
          .split('\n')
          .map((label) => label.trim())
          .where((label) => label.isNotEmpty)
          .toList();

      if (_labels == null || _labels!.isEmpty)
        throw Exception("Labels não carregadas.");

      _isModelLoaded = true;
      print(
          "✅ RealtimeDetectionController: Modelo e Labels carregados (${_labels!.length} labels).");
    } catch (e) {
      print(
          '❌ RealtimeDetectionController: Erro ao carregar modelo/labels: $e');
      modelErrorMessage.value = "Erro ao carregar modelo: ${e.toString()}";
      _isModelLoaded = false;
      _interpreter?.close();
      _interpreter = null;
      _labels = null;
    }
  }

  // ===========================================================================
  // Controle do Stream e Processamento
  // ===========================================================================

  void startDetection() {
    if (!isCameraInitialized.value ||
        cameraController == null ||
        !_isModelLoaded ||
        _interpreter == null) {
      print(
          "⚠️ RealtimeDetectionController: Não pode iniciar detecção - não inicializado.");
      return;
    }
    if (cameraController!.value.isStreamingImages) {
      print("⚠️ RealtimeDetectionController: Stream já iniciado.");
      return;
    }

    print("🚀 RealtimeDetectionController: Iniciando stream de imagens...");
    _lastProcessedFrameTime = null; // Reseta timer
    processingError.value = ''; // Limpa erros de processamento

    cameraController!.startImageStream((CameraImage cameraImage) {
      final now = DateTime.now();
      // Controle de frequência e lock de processamento
      if ((_lastProcessedFrameTime != null &&
              now.difference(_lastProcessedFrameTime!) < _processInterval) ||
          isDetecting.value) {
        return;
      }
      _lastProcessedFrameTime = now;
      isDetecting.value = true; // Ativa o lock

      // Chama o processamento (sem await para não bloquear stream)
      _processCameraImage(cameraImage).whenComplete(() {
        isDetecting.value =
            false; // Libera o lock APÓS o processamento (sucesso ou falha)
      });
    });
  }

  Future<void> stopDetection() async {
    if (cameraController != null && cameraController!.value.isStreamingImages) {
      try {
        await cameraController!.stopImageStream();
        print("🛑 RealtimeDetectionController: Stream parado.");
      } catch (e) {
        print("⚠️ RealtimeDetectionController: Erro ao parar stream: $e");
      }
    }
    isDetecting.value = false; // Garante que o lock seja liberado
  }

  /// Processa um frame da câmera para inferência TFLite.
  Future<void> _processCameraImage(CameraImage cameraImage) async {
    if (_interpreter == null || _labels == null) return;

    img.Image? preprocessedImage;
    Float32List? inputBytes;

    try {
      final stopwatch = Stopwatch()..start();

      // --- 1. Pré-processamento (Conversão + Redimensionamento) ---
      preprocessedImage = _preprocessCameraImage(cameraImage);
      if (preprocessedImage == null) {
        print("⚠️ Preprocessamento falhou.");
        return; // Sai se não conseguiu pré-processar
      }
      print("⏱️ Preprocessamento: ${stopwatch.elapsedMilliseconds} ms");
      stopwatch.reset();
      stopwatch.start();

      // --- 2. Preparar Input Tensor ---
      var inputTensor = _interpreter!.getInputTensors().first;
      var inputShape = inputTensor.shape; // Ex: [1, 224, 224, 3]
      if (inputTensor.type != tfl.TensorType.float32)
        throw Exception("Modelo não é Float32");

      // Normaliza para [-1.0, 1.0] (ajuste se necessário)
      inputBytes = _imageToByteListFloat32_11(
          preprocessedImage, inputShape[1], inputShape[2]);
      ByteBuffer inputBuffer = inputBytes.buffer;
      print(
          "⏱️ Preparação Tensor Entrada: ${stopwatch.elapsedMilliseconds} ms");
      stopwatch.reset();
      stopwatch.start();

      // --- 3. Preparar Output Tensor ---
      var outputTensor = _interpreter!.getOutputTensors().first;
      var outputShape = outputTensor.shape; // Ex: [1, num_classes]
      if (outputTensor.type != tfl.TensorType.float32)
        throw Exception("Saída não é Float32");
      if (outputShape.length != 2 || outputShape[0] != 1)
        throw Exception("Shape de saída inválido");
      int numClasses = outputShape[1];
      var outputBuffer = Float32List(numClasses);

      // --- 4. Executar Inferência ---
      _interpreter!.run(inputBuffer, outputBuffer.buffer.asByteData());
      print("⏱️ Inferência: ${stopwatch.elapsedMilliseconds} ms");

      // --- 5. Pós-processamento ---
      List<double> results = outputBuffer.toList();
      double highestScore = -double.infinity; // Inicia com menor valor possível
      int bestIndex = -1;

      for (int i = 0; i < results.length; i++) {
        if (results[i] > highestScore) {
          highestScore = results[i];
          bestIndex = i;
        }
      }

      // Atualiza UI com resultado válido e acima do limiar
      if (bestIndex != -1 && bestIndex < _labels!.length) {
        final detected = _labels![bestIndex];
        if (highestScore >= confidenceThreshold) {
          if (detectedLabel.value != detected) {
            // Atualiza só se mudar
            detectedLabel.value = detected;
            confidence.value = highestScore; // Guarda a confiança real
            print(
                '✅ Detectado: $detected (Score: ${highestScore.toStringAsFixed(3)})');
          }
        } else {
          if (detectedLabel.value.isNotEmpty)
            detectedLabel.value = ''; // Limpa se confiança baixa
        }
      } else {
        if (detectedLabel.value.isNotEmpty)
          detectedLabel.value = ''; // Limpa se índice inválido
      }
      processingError.value =
          ''; // Limpa erro anterior se processou com sucesso
    } catch (e, s) {
      print("❌ Erro em _processCameraImage: $e\n$s");
      processingError.value = "Erro no processamento: ${e.toString()}";
      detectedLabel.value = ''; // Limpa detecção em caso de erro
    }
    // O lock _isDetecting é liberado no whenComplete do chamador
  }

  // ===========================================================================
  // Funções Auxiliares de Imagem (Mantenha as que funcionam para você)
  // ===========================================================================

  /// Pré-processa a imagem: Converte formato e redimensiona para o modelo.
  img.Image? _preprocessCameraImage(CameraImage cameraImage) {
    try {
      img.Image? image;
      final stopwatch = Stopwatch()..start();
      if (cameraImage.format.group == ImageFormatGroup.yuv420) {
        image = _convertYUV420toImage(cameraImage);
      } else if (cameraImage.format.group == ImageFormatGroup.bgra8888) {
        image = _convertBGRA8888toImage(cameraImage);
      } else {
        print("Formato não suportado: ${cameraImage.format.group}");
        return null;
      }
      stopwatch.stop();
      if (image == null) {
        print("Falha na conversão de formato.");
        return null;
      }
      print("⏱️ Conversão Formato: ${stopwatch.elapsedMilliseconds} ms");

      if (_interpreter == null) return null;
      var inputShape = _interpreter!.getInputTensors().first.shape;
      final int modelInputHeight = inputShape[1];
      final int modelInputWidth = inputShape[2];

      stopwatch.reset();
      stopwatch.start();
      // Redimensiona mantendo proporção e cortando (ou use padding)
      img.Image resizedImage = img.copyResizeCropSquare(image,
          size: modelInputWidth, interpolation: img.Interpolation.linear);
      stopwatch.stop();
      print("⏱️ Redimensionamento: ${stopwatch.elapsedMilliseconds} ms");

      return resizedImage;
    } catch (e, s) {
      print("❌ Erro em _preprocessCameraImage (interno): $e\n$s");
      return null;
    }
  }

  // --- Funções de Conversão YUV/BGRA (Mantenha as suas ou otimize) ---
  img.Image? _convertYUV420toImage(CameraImage image) {
    /* ... Sua implementação ... */ return null;
  }

  img.Image _convertBGRA8888toImage(CameraImage image) {
    /* ... Sua implementação ... */ throw UnimplementedError();
  }

  // --- Funções de Conversão para ByteList (Float32) ---
  Float32List _imageToByteListFloat32_11(
      img.Image image, int inputHeight, int inputWidth) {
    var buffer = Float32List(1 * inputHeight * inputWidth * 3);
    var bufferIndex = 0;
    for (var y = 0; y < inputHeight; y++) {
      for (var x = 0; x < inputWidth; x++) {
        var pixel = image.getPixel(x, y);
        buffer[bufferIndex++] = (pixel.rNormalized * 2.0) - 1.0;
        buffer[bufferIndex++] = (pixel.gNormalized * 2.0) - 1.0;
        buffer[bufferIndex++] = (pixel.bNormalized * 2.0) - 1.0;
      }
    }
    return buffer;
  }

  Float32List _imageToByteListFloat32_01(
      img.Image image, int inputHeight, int inputWidth) {
    // ... (implementação para 0..1) ...
    var buffer = Float32List(1 * inputHeight * inputWidth * 3);
    var bufferIndex = 0;
    for (var y = 0; y < inputHeight; y++) {
      for (var x = 0; x < inputWidth; x++) {
        var pixel = image.getPixel(x, y);
        buffer[bufferIndex++] = pixel.rNormalized.toDouble(); // Já está em 0..1
        buffer[bufferIndex++] = pixel.gNormalized.toDouble();
        buffer[bufferIndex++] = pixel.bNormalized.toDouble();
      }
    }
    return buffer;
  }

  // ===========================================================================
  // Limpeza
  // ===========================================================================
  Future<void> disposeResources() async {
    print("🧹 RealtimeDetectionController: Disposing resources...");
    await stopDetection(); // Garante que o stream pare

    final controllerRef = cameraController;
    cameraController = null; // Define como nulo primeiro
    isCameraInitialized.value = false;
    if (controllerRef != null) {
      try {
        await controllerRef.dispose();
        print("📸 CameraController disposed.");
      } catch (e) {
        print("⚠️ Erro ao descartar CameraController: $e");
      }
    }

    try {
      _interpreter?.close();
      print("🧠 Interpreter closed.");
    } catch (e) {
      print("⚠️ Erro ao fechar Interpreter: $e");
    } finally {
      _interpreter = null;
      _isModelLoaded = false;
      _labels = null;
    }
    print("🧹 RealtimeDetectionController: Cleanup complete.");
  }
}
