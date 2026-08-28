// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NewPasswordRequest {
  final String password;
  final String code;

  NewPasswordRequest({required this.password, required this.code});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'code': code,
    };
  }

  String toJson() => json.encode(toMap());
}
