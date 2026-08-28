import 'dart:convert';

class CreateMedicalRecordResponse {
  final String id;

  CreateMedicalRecordResponse(this.id);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory CreateMedicalRecordResponse.fromMap(Map<String, dynamic> map) {
    return CreateMedicalRecordResponse(
      map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateMedicalRecordResponse.fromJson(String source) =>
      CreateMedicalRecordResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
