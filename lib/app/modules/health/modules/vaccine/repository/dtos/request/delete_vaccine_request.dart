import 'dart:convert';

class DeleteVaccineRequest {
  final String id;

  DeleteVaccineRequest(
    this.id,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());
}
