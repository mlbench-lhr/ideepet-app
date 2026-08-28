// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetMedicalRecordRequest {
  final String petId;

  GetMedicalRecordRequest(this.petId);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'petId': petId,
    };
  }

  factory GetMedicalRecordRequest.fromMap(Map<String, dynamic> map) {
    return GetMedicalRecordRequest(
      map['petId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetMedicalRecordRequest.fromJson(String source) =>
      GetMedicalRecordRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
