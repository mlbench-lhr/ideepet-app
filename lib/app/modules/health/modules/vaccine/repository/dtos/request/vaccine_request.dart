import 'dart:convert';

class VaccineRequest {
  final String petId;

  VaccineRequest(this.petId,);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'petId': petId,
    };
  }

  String toJson() => json.encode(toMap());
}
