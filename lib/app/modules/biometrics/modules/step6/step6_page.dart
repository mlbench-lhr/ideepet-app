import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:idee_pet/app/modules/biometrics/widgets/detector_widget.dart';
import 'package:idee_pet/lib.dart';
import 'package:lottie/lottie.dart';

class BiometricsStep6Page extends GetView<BiometricsController> {
  const BiometricsStep6Page({super.key});

  @override
  Widget build(BuildContext context) {
    //controller.initializeCameraAndModel();
    // controller.initStateAsync();
    ScreenParams.screenSize = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: controller.isReady.isTrue
            ? Stack(
                children: [
                  DetectorWidget(
                    onTakePicture: controller.captureAndStoreImage,
                    onResult: controller.onResult,
                  ),
                  // Positioned.fill(
                  //   child: Opacity(
                  //     opacity: controller.detectedLabel.isEmpty ? 0 : 0.6,
                  //     child: Container(
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // ),
                  if (controller.detectedLabel.isEmpty)
                    Positioned(
                      bottom: 100,
                      left: 20,
                      right: 20,
                      child: Text(
                        "Pet não reconhecido, por favor posicione o pet em frente à câmera e tente novamente",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  Positioned(
                    top: 40,
                    right: 20,
                    child: Lottie.asset(
                      controller.pet.type == PetType.dog
                          ? 'assets/onboarding_biometric/dog.json'
                          : 'assets/onboarding_biometric/cat.json',
                      width: 100,
                      height: 100,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                          icon: CircleAvatar(
                            backgroundColor: AppColors.greyWhite,
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.primary,
                            ),
                          ),
                          onPressed: () {
                            controller.previosPage();
                          },
                        ),
                        SizedBox(height: 14),
                        Text(
                          'Reconhecimento',
                          style: AppTextStyles.poppinsExtraBold(
                                  color: AppColors.background, fontSize: 26)
                              .style,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Posicione o focinho do seu pet dentro da área\nindicada para capturar a identidade única dele.',
                          style: AppTextStyles.poppinsMedium(
                                  color: AppColors.background, fontSize: 10)
                              .style,
                        ),
                        Spacer(),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.textSelectCamera.length,
                          itemBuilder: (BuildContext context, int index) {
                            final int length =
                                controller.textSelectCamera.length;
                            final double opacity =
                                (index == length - 1) ? 1.0 : 0.4;
                            final double scaleFactor =
                                0.8 + (0.2 * (index / (length - 1)));

                            return Opacity(
                              opacity: opacity,
                              child: Transform.scale(
                                scale: scaleFactor,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    controller.textSelectCamera[index],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: controller.biometricImages.isNotEmpty
                              ? Container(
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: LinearProgressIndicator(
                                      value: controller.progressBiometric(),
                                      backgroundColor: Colors.transparent,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.primary),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
