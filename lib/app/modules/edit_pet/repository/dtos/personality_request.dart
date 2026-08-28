import 'package:idee_pet/app/app.dart';

class PersonalityRequest {
  final String id;
  final List<PetPersonality> personalitys;

  PersonalityRequest({
    required this.id,
    required this.personalitys,
  });

  Map<String, dynamic> toJson() {
    return {
      'personality': personalitys.map((p) => p.json).toList(),
    };
  }
}
