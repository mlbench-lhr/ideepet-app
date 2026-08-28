import 'dart:convert';

class UpdateHealthPlanRequest {
  final String petId;
  final String planId;

  UpdateHealthPlanRequest(this.petId, this.planId);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'petId': petId,
      'health_plan_id': planId,
    };
  }

  String toJson() => json.encode(toMap());
}
