import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/modules/biometric/biometric_controller.dart';
import 'package:idee_pet/app/modules/biometrics/widgets/detector_widget.dart';

class BiometicScanning extends GetView<BiometricController> {
  const BiometicScanning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: CircleAvatar(
            backgroundColor: AppColors.greyWhite,
            child: Icon(Icons.arrow_back, color: AppColors.primary),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            DetectorWidget(
              onTakePicture: controller.captureAndStoreImage,
              onResult: controller.onResult,
            ),
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
            Positioned(
                top: 115,
                left: 100,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                      ),
                      SizedBox(
                        width: 8,
                      ),
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
                )),
          ],
        ),
      ),
    );
  }
}
