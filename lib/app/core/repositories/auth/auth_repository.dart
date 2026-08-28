import 'dart:async';
import 'dart:convert';

import 'package:idee_pet/app/app.dart';

class AuthRepository extends BaseRepository {
  static const String postRefreshTokenPath = '/session/revalidate';
  static const String postLoginPath = '/session';

  @override
  void onInit() {
    super.allowBypass = true;
    super.onInit();
  }

  Future<BaseResponse<SignInResponse>> signIn(SignInRequest request) async {
    final response = await post(
      postLoginPath,
      request.toJson(),
    );
    return BaseResponse.create(
        response: response, fromMap: (data) => SignInResponse.fromJson(data));
  }

  Future<BaseResponse<RefreshTokenResponse>> refreshToken(
      RefreshTokenRequest request) async {
    final response = await post(
      postRefreshTokenPath,
      request.toJson(),
    );

    return BaseResponse.create(
      response: response,
      fromMap: (data) => RefreshTokenResponse.fromJson(data),
    );
  }

  static const postForgotPasswordPath = '/users/forgetPassword';

  Future<BaseResponse<void>> sendResetEmail({required String email}) async {
    final request = {'email': email};
    final response = await post(postForgotPasswordPath, json.encode(request));
    return BaseResponse.createCustom(
        success: (response.statusCode ?? 400) < 400,
        result: null,
        statusCode: response.statusCode);
  }
}
