import 'package:idee_pet/app/app.dart';

class CreatePetRequest {
  final PetType type;
  final String name;
  final PetWeight weight;
  final BreedResponse breed;
  final PetSize size;
  final DateTime birthDate;
  final PetSex sex;
  final List<String> foods;
  final bool healthPlan;
  final bool healthCondition;
  final String? healthConditionName;
  final List<PetPersonality> personalitys;
  final String? healthPlanId;
  final String? healthSeverity;
  final DateTime? healthDate;

  CreatePetRequest({
    required this.type,
    required this.name,
    required this.weight,
    required this.breed,
    required this.size,
    required this.birthDate,
    required this.sex,
    required this.foods,
    required this.healthPlan,
    required this.healthCondition,
    this.healthConditionName,
    required this.personalitys,
    this.healthPlanId,
    this.healthSeverity,
    this.healthDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'name': name,
      'weight': weight.value,
      'birth_date': formatDateTimeToUTC(birthDate),
      'breed': breed.name,
      'breed_id': breed.id,
      'size': size.json,
      'sex': sex.json,
      'food': foods,
      'is_health_plan': healthPlan,
      'is_health_condition': healthCondition,
      'personality': personalitys.map((p) => p.json).toList(),
      'health_condition': healthConditionName,
      'health_plan_id': healthPlanId,
      'health_severity': healthSeverity != null
          ? parseSeverityHealth(healthSeverity!).name
          : null,
      'health_date':
          healthDate != null ? formatDateTimeToUTC(healthDate) : null,
    };
  }
}
