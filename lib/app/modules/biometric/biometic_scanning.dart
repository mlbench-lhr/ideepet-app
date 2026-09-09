import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/oval_outline.dart';
import 'package:idee_pet/app/core/core_old/widgets/svgs.dart';
import 'package:idee_pet/app/core/helpers/messages.dart';
import 'package:idee_pet/app/modules/biometric/biometric_controller.dart';

class BiometicScanning extends StatefulWidget {
  const BiometicScanning({super.key});

  @override
  State<BiometicScanning> createState() => _BiometicScanningState();
}

class _BiometicScanningState extends State<BiometicScanning>
    with WidgetsBindingObserver {
  final BiometricController controller = Get.find<BiometricController>();

  CameraController? _cameraController;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      if (mounted) {
        showError(message: 'Nenhuma câmera disponível neste dispositivo.');
      }
      return;
    }

    final cameraController = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize();

    if (!mounted) {
      await cameraController.dispose();
      return;
    }

    setState(() => _cameraController = cameraController);
  }

  Future<void> _captureImages() async {
    final cameraController = _cameraController;
    if (cameraController == null ||
        !cameraController.value.isInitialized ||
        _isCapturing) {
      return;
    }

    setState(() => _isCapturing = true);

    for (int i = 0; i < 3; i++) {
      try {
        final file = await cameraController.takePicture();
        controller.captureAndStoreImage(file);
      } catch (e) {
        debugPrint('Error taking picture: $e');
      }
      if (i < 2) {
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }

    if (mounted) setState(() => _isCapturing = false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cameraController = _cameraController;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      cameraController.dispose();
      _cameraController = null;
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: CircleAvatar(
            backgroundColor: AppColors.greyWhite,
            child: Icon(Icons.arrow_back, color: AppColors.primary),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _CameraPreviewBackground(cameraController: _cameraController),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Positioned(
                      child: Text(
                    "Reconhecimento",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        color: AppColors.primary),
                  )),
                  Positioned(
                    top: 45,
                    left: 0,
                    right: 0,
                    child: Text(
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      "Posicione o focinho dentro da área indicada e \nsegure firme por 5 segundos.",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                          color: AppColors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: _HoldToScanControls(
              recordDuration: const Duration(seconds: 5),
              isCapturing: _isCapturing,
              onHoldComplete: _captureImages,
            ),
          ),
        ],
      ),
    );
  }
}

class _CameraPreviewBackground extends StatelessWidget {
  const _CameraPreviewBackground({required this.cameraController});

  final CameraController? cameraController;

  @override
  Widget build(BuildContext context) {
    final controller = cameraController;
    if (controller == null || !controller.value.isInitialized) {
      return Container(color: Colors.black);
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller.value.previewSize!.height,
          height: controller.value.previewSize!.width,
          child: CameraPreview(controller),
        ),
      ),
    );
  }
}

class _HoldToScanControls extends StatefulWidget {
  const _HoldToScanControls({
    required this.recordDuration,
    required this.onHoldComplete,
    this.isCapturing = false,
  });

  final Duration recordDuration;
  final VoidCallback onHoldComplete;
  final bool isCapturing;

  @override
  State<_HoldToScanControls> createState() => _HoldToScanControlsState();
}

class _HoldToScanControlsState extends State<_HoldToScanControls>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.recordDuration,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _stopRecording();
          widget.onHoldComplete();
        }
      });
  }

  void _startRecording() {
    if (_isRecording || widget.isCapturing) return;
    setState(() => _isRecording = true);
    _controller.forward(from: 0);
  }

  void _stopRecording() {
    if (!_isRecording) return;
    setState(() => _isRecording = false);
    _controller.stop();
    _controller.reset();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 125,
            left: 0,
            right: 0,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ColoredBox(
                  color: AppColors.primary,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Segure firme · 5s",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.background,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Center(
              child: OvalOutline(
                width: 230,
                height: 302,
                child: CustomLogo.logoOutline(height: 130, width: 130),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTapDown: (_) => _startRecording(),
                onTapUp: (_) => _stopRecording(),
                onTapCancel: _stopRecording,
                child: SizedBox(
                  height: 96,
                  width: 96,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) => Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 96,
                          width: 96,
                          child: CircularProgressIndicator(
                            value: _controller.value,
                            strokeWidth: 14,
                            backgroundColor:
                                AppColors.primary.withValues(alpha: 0.15),
                            valueColor:
                                const AlwaysStoppedAnimation(Colors.red),
                          ),
                        ),
                        child!,
                      ],
                    ),
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: ClipOval(
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: CustomLogo.logoIcon(height: 30, width: 30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
