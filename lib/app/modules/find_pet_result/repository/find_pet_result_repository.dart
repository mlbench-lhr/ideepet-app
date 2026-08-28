import 'dart:io';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/modules/find_pet_result/repository/find_pet_entity.dart';
import 'package:idee_pet/app/modules/find_pet_result/repository/sent_data_pet.dart';

class FindPetResultRepository extends BaseRepository {
  Future<BaseResponse<FindPetResult>> findPet(
      List<File> images, void Function(double progress)? onProgress) async {
    redirect = false;
    final totalBytes = images.fold<int>(
      0,
      (sum, file) => sum + file.lengthSync(),
    );
    final formData = FormData({
      "files": images
          .map((file) =>
              MultipartFile(file, filename: file.path.split('/').last))
          .toList(),
    });
    final response = await post(
      '/pets/identify_pet/',
      formData,
      uploadProgress: (double sent) {
        if (onProgress != null && totalBytes > 0) {
          double progress = sent / totalBytes;
          if (progress > 1) progress = 1;
          onProgress(progress);
        }
      },
    );

    if ((response.statusCode ?? 500) < 400) {
      //showSuccess(message: 'Biometria enviada com sucesso!');
    } else {
      showError(message: 'Erro ao enviar biometria!');
    }
    redirect = true;

    return BaseResponse.create(
      response: response,
      fromMap: (data) => FindPetResult.fromJson(data),
    );
  }

  Future<BaseResponse<void>> sendDataPet(SentDataPet request) async {
    redirect = false;
    final response = await post('/pets/found_pet/', request.toJson());
    redirect = true;
    return BaseResponse.create(response: response);
  }
}
