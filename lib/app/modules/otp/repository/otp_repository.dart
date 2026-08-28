import 'package:idee_pet/lib.dart';

class OtpRepository extends BaseRepository {
  OtpRepository() : super(allowBypass: true);

  static const postResendCodePath = '/users/activate/refresh';
  static const putVerifyCodePath = '/users/activate';

  Future<BaseResponse<RefreshCodeResponse>> refreshCode(
      RefreshCodeRequest request) async {
    final response = await post(
      postResendCodePath,
      request.toJson(),
    );
    return BaseResponse.create(
      response: response,
      fromMap: (data) => RefreshCodeResponse.fromMap(
        data,
      ),
    );
  }

  Future<BaseResponse<SignInResponse>> activeAccount(
      ActiveAccountRequest request) async {
    final response = await put(
      putVerifyCodePath,
      request.toJson(),
    );
    return BaseResponse.create(
      response: response,
      fromMap: (data) => SignInResponse.fromJson(
        data,
      ),
    );
  }
}
