import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/svgs.dart';
import 'package:idee_pet/app/modules/biometrics/modules/capture_image/capture_image_controller.dart';

class CaptureImagePage extends GetView<CaptureImageController> {
  const CaptureImagePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        return controller.isCameraInitialized()
            ? Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(
                      controller.cameraController!,
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
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    left: 0,
                    right: 0,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: controller.isTakingPicture()
                            ? null
                            : () {
                                controller.captureImage();
                              },
                        customBorder: CircleBorder(),
                        child: Center(
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 10,
                              ),
                            ),
                            child: ClipOval(
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: CustomLogo.logoIcon(
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Center(child: CircularProgressIndicator());
      }));
}
