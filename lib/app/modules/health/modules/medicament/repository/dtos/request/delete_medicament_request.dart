import 'dart:convert';

class DeleteMedicamentRequest {
  final String id;

  DeleteMedicamentRequest(
    this.id,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());
}
