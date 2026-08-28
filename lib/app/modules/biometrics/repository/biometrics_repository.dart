import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:idee_pet/app/app.dart';

class BiometricsRepository extends BaseRepository {
  Future<BaseResponse<void>> sendPetProfile(PetProfileRequest request) async {
    final formData = FormData(request.toMap());
    final response = await post(
      '/pets/${request.id}/petAvatar',
      formData,
      uploadProgress: (progress) {
        request.onProgress(progress);
      },
    );
    return BaseResponse.create(
      response: response,
    );
  }

  Future<BaseResponse<void>> sendBiometry(PetBiometryRequest request) async {
    final formData = request.toFormData();
    final response = await post('/pets/${request.id}/biometry', formData);

    if ((response.statusCode ?? 500) < 400) {
      showSuccess(message: 'Biometria enviada com sucesso!');
    } else {
      showError(message: 'Erro ao enviar biometria!');
    }

    return BaseResponse.create(
      response: response,
    );
  }
}
