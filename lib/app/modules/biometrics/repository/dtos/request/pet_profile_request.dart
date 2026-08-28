import 'dart:io';

import 'package:get/get_connect/http/src/multipart/multipart_file.dart';


class PetProfileRequest {
  final String id;
  final File image;
  void Function(double progress) onProgress;

  PetProfileRequest({
    required this.id,
    required this.image,
    required this.onProgress,
  });

  Map<String, dynamic> toMap() {
    return {
      'file': MultipartFile(
        image,
        filename: image.path.split('/').last,
        contentType: 'multipart/form-data',
      ),
    };
  }
}
