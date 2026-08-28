class LoginResult {
  final LoginStatus status;
  final String? otpCode;

  LoginResult(this.status, {this.otpCode});
}

enum LoginStatus {
  success,
  error,
  otpRequired,
}
