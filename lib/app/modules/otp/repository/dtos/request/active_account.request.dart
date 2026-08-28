class ActiveAccountRequest {
  final String code;
  final String token;
  ActiveAccountRequest({
    required this.code,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'token': token,
    };
  }
}
