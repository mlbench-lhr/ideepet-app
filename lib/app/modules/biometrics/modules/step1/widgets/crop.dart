// import 'package:flutter/material.dart';
// import 'package:idee_pet/app/core/core_old/colors.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'dart:io';

// Future<File?> cropImage(File imageFile) async {
//   final croppedFile = await ImageCropper().cropImage(
//     sourcePath: imageFile.path,
//     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//     compressQuality: 100,
//     maxWidth: 1080,
//     maxHeight: 1080,
//     compressFormat: ImageCompressFormat.jpg,
//     uiSettings: [
//       AndroidUiSettings(
//         toolbarTitle: 'Recortar Imagem',
//         cropStyle: CropStyle.circle,
//         toolbarColor: Colors.black,
//         statusBarColor: Colors.black,
//         toolbarWidgetColor: Colors.white,
//         initAspectRatio: CropAspectRatioPreset.square,
//         lockAspectRatio: true,
//         hideBottomControls: false,
//         showCropGrid: false,
//         backgroundColor: Colors.black,
//       ),
//       IOSUiSettings(
//         title: 'Recortar Imagem',
//         doneButtonTitle: 'Concluir',
//         cancelButtonTitle: 'Cancelar',
//         rotateButtonsHidden: false,
//         aspectRatioLockEnabled: true,
//         resetAspectRatioEnabled: false,
//         aspectRatioPickerButtonHidden: true,
//       ),
//     ],
//   );

//   if (croppedFile != null) {
//     return File(croppedFile.path);
//   }
//   return null;
// }
