import 'package:idee_pet/app/app.dart';

class NewPasswordRepository extends BaseRepository {
  NewPasswordRepository() : super(allowBypass: true);

  static const String postResetPasswordPath = '/users/forgetPassword/code';

  Future<BaseResponse<void>> changePassword(NewPasswordRequest request) async {
    final response = await post(postResetPasswordPath, request.toJson());
    return BaseResponse.create(
      response: response,
    );
  }
}
