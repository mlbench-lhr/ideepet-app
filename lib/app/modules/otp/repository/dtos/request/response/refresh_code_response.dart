// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RefreshCodeResponse {
  final String code;

  RefreshCodeResponse(this.code);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
    };
  }

  factory RefreshCodeResponse.fromMap(Map<String, dynamic> map) {
    return RefreshCodeResponse(
      map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RefreshCodeResponse.fromJson(String source) =>
      RefreshCodeResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
