import 'dart:convert';

class MedicamentRequest {
  final String petId;

  MedicamentRequest(
    this.petId,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'petId': petId,
    };
  }

  String toJson() => json.encode(toMap());
}
