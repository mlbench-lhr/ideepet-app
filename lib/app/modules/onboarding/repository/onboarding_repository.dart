import 'package:flutter/foundation.dart';
import 'package:idee_pet/lib.dart';

class OnboardingRepository extends BaseRepository {
  OnboardingRepository() : super(allowBypass: true);
  static const pathPostCreateUser = '/users';
  Future<BaseResponse<CreateUserResponse?>> createUser(
    CreateUserRequest request,
  ) async {
    final formData = request.toFormData();

    // ?? LOG DO FORMDATA
    debugPrint('===== CREATE USER | FORM DATA =====');

    for (final field in formData.fields) {
      debugPrint('FIELD -> ${field.key}: ${field.value}');
    }

    for (final file in formData.files) {
      debugPrint('FILE -> ${file.key}: ${file.value.filename}');
    }

    debugPrint('==================================');

    final response = await post(pathPostCreateUser, formData,
        contentType: 'multipart/form-data');

    // ?? LOG DA RESPOSTA
    debugPrint('===== CREATE USER | RESPONSE =====');
    debugPrint('STATUS -> ${response.statusCode}');
    // debugPrint('DATA   -> ${response.data}');
    debugPrint('=================================');

    return BaseResponse.create(
      response: response,
      fromMap: (data) => CreateUserResponse.fromJson(data),
    );
  }
}
