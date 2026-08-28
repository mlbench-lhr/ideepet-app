import 'dart:io';

import 'package:easy_image_cropper/easy_image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:image_picker/image_picker.dart';

class OnboardingProfileStep2 extends StatelessWidget {
  const OnboardingProfileStep2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    final cropKey = GlobalKey<ImgCropState>();

    Future<void> handlePickImage(
      BuildContext context,
      ImageSource source,
    ) async {
      File? image;

      if (source == ImageSource.gallery) {
        image = await controller.pickImage(source); // se já existir
      } else {
        await controller.goToCaptureImage(
          onImageCaptured: (String path) {
            Get.back(result: image = File(path));
          },
        );
      }

      if (image == null) return;

      File? croppedImage;

      await Get.bottomSheet(
        backgroundColor: AppColors.background,
        isScrollControlled: true,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: ImgCrop(
                    key: cropKey,
                    chipShape: ChipShape.circle,
                    maximumScale: 4,
                    image: FileImage(image!),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomButton.filled(
                title: Text(
                  'Concluir',
                  style: AppTextStyles.poppinsSemiBold(
                    color: AppColors.white,
                  ).style,
                ),
                action: () async {
                  croppedImage = await cropKey.currentState!
                      .cropCompleted(image!, pictureQuality: 900);

                  if (croppedImage != null) {
                    controller.setProfileImage(croppedImage!);
                    Get.back(); // fecha bottomSheet
                  }
                },
              ),
              const SizedBox(height: 10),
              CustomButton.transparent(
                action: Get.back,
                title: Text(
                  'Cancelar',
                  style: AppTextStyles.poppinsSemiBold(
                    color: AppColors.primary,
                  ).style,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            icon: CircleAvatar(
              backgroundColor: AppColors.greyWhite,
              child: Icon(
                Icons.arrow_back,
                color: AppColors.primary,
              ),
            ),
            onPressed: () {
              if (controller.isChanging) {
                Get.back();
              } else {
                controller.changePage(0);
              }
            },
          ),
          SizedBox(height: 10),
          Text(
            'Agora vamos adicionar\nsua foto ao perfil',
            style: AppTextStyles.title(fontSize: 26).style,
          ),
          SizedBox(height: 30),
          Obx(() {
            final size = MediaQuery.of(context).size.width * 0.6;

            Widget image;

            if (controller.profileImage.value != null) {
              // 📸 nova imagem escolhida
              image = Image.file(
                controller.profileImage.value!,
                width: size,
                height: size,
                fit: BoxFit.cover,
              );
            } else if (controller.profileImageUrl.isNotEmpty) {
              // 🌐 imagem já salva no backend
              image = Image.network(
                controller.profileImageUrl.value,
                width: size,
                height: size,
                fit: BoxFit.cover,
              );
            } else {
              // 👤 placeholder padrão
              image = Image.asset(
                'assets/icon_profile.png',
                width: size,
                height: size,
                fit: BoxFit.cover,
              );
            }

            return Center(
              child: ClipOval(child: image),
            );
          }),
          SizedBox(height: 30),
          Obx(() {
            final hasImage = controller.profileImage.value != null;

            return controller.loadingCreate.isTrue
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : CustomButton.filled(
                    action: hasImage
                        ? () {
                            controller.validate();
                            controller.next();
                          }
                        : () => handlePickImage(context, ImageSource.camera),
                    title: Text(
                      hasImage ? 'Continuar' : 'Tirar foto',
                      style: AppTextStyles.poppinsSemiBold(
                        color: AppColors.background,
                      ).style,
                    ),
                  );
          }),
          SizedBox(height: 18),
          Obx(() {
            final hasImage = controller.profileImage.value != null;

            return CustomButton.transparent(
              action: hasImage
                  ? controller.clearProfileImage
                  : () => handlePickImage(context, ImageSource.gallery),
              title: Text(
                hasImage ? 'Tirar outra foto' : 'Escolher da galeria',
                style: AppTextStyles.poppinsSemiBold(
                  color: AppColors.primary,
                ).style,
              ),
            );
          }),
          SizedBox(height: 18),
          Center(
            child: TextButton(
              onPressed: () => controller.next(),
              child: Text(
                'Escolher depois',
                style: TextStyle(
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                  decorationThickness: 1.5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
