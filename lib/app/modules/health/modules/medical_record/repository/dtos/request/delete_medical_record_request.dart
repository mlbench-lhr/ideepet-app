// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeleteMedicalRecordRequest {
  final String id;

  DeleteMedicalRecordRequest(this.id);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory DeleteMedicalRecordRequest.fromMap(Map<String, dynamic> map) {
    return DeleteMedicalRecordRequest(
      map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeleteMedicalRecordRequest.fromJson(String source) =>
      DeleteMedicalRecordRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
