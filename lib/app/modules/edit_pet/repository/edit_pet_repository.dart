import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/modules/new_pet/repository/dtos/request/breed_request.dart';

class EditPetRepository extends BaseRepository {
  static const String path = '/pets';

  Future<BaseResponse<Pet>> updateFoods(FoodRequest request) async {
    final value = request.toJson();
    final response = await patch('$path/${request.id}', value);
    return BaseResponse.create(
      response: response,
    );
  }

  Future<BaseResponse<Pet>> updatePersonality(
      PersonalityRequest request) async {
    final response = await patch('$path/${request.id}', request.toJson());
    return BaseResponse.create(
      response: response,
    );
  }

  Future<BaseResponse<Pet>> updateDetails(DetailsRequest request) async {
    // for (final field in request.toFormData().fields) {
    //   debugPrint('FIELD -> ${field.key}: ${field.value}');
    // }

    final response = await patch('$path/${request.id}', request.toJson());
    return BaseResponse.create(
      response: response,
    );
  }

  Future<BaseResponse<Pet>> updateSize(SizeRequest request) async {
    final response = await patch('$path/${request.id}', request.toJson());
    return BaseResponse.create(
      response: response,
    );
  }

  Future<BaseResponse<List<BreedResponse>>> getBreeds(
      BreedRequest request) async {
    final response = await get(request.type.route);

    return BaseResponse.createList(
      response: response,
      fromMap: (data) => BreedResponse.fromJson(data),
    );
  }

  Future<BaseResponse<void>> deletePet(String id) async {
    final response = await delete('$path/$id');
    return BaseResponse.create(
      response: response,
    );
  }

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
}
