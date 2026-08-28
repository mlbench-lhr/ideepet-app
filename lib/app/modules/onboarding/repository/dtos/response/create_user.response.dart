class CreateUserResponse {
  final String code;
  CreateUserResponse({
    required this.code,
  });

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserResponse(
      code: json['code'],
    );
  }
}
