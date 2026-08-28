// import 'package:get/get_connect/connect.dart';
import 'package:idee_pet/app/app.dart';

class DetailsRequest {
  final String? id;
  final String? petName;
  final DateTime? birthDate;
  final PetSex? petSex;
  final PetWeight? weight;
  final BreedResponse? breed;

  DetailsRequest({
    this.id,
    this.petName,
    this.birthDate,
    this.petSex,
    this.weight,
    this.breed,
  });

  Map<String, dynamic> toJson() {
    return {
      if (petName != null) 'name': petName,
      if (birthDate != null) 'birth_date': formatDateTimeToUTC(birthDate),
      if (petSex != null) 'sex': petSex!.json,
      if (weight != null) 'weight': weight!.value,
      // if (breed != null) 'breed': breed!.name,
      if (breed != null) 'breed_id': breed!.id,
    };
  }

  // FormData toFormData() => FormData(toJson());
}
