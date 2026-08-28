class SignInResponse {
  final String accessToken;
  final String refreshToken;
  final String? code;
  SignInResponse({
    required this.accessToken,
    required this.refreshToken,
    this.code,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return SignInResponse(
        code: json['code'],
        accessToken: '',
        refreshToken: '',
      );
    }
    return SignInResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
