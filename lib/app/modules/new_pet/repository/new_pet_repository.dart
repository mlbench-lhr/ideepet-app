import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/modules/new_pet/repository/dtos/request/create_pet_request.dart';

import 'dtos/request/breed_request.dart';

class NewPetRepository extends BaseRepository {
  static const String createPetPath = '/pets';
  static const String getHealthPlansPath = '/health-plans';

  Future<BaseResponse<List<BreedResponse>>> getBreeds(
      BreedRequest request) async {
    final response = await get(request.type.route);

    return BaseResponse.createList(
      response: response,
      fromMap: (data) => BreedResponse.fromJson(data),
    );
  }

  Future<BaseResponse<Pet>> createPet(CreatePetRequest request) async {
    final response = await post(createPetPath, request.toJson());

    return BaseResponse.create(
      response: response,
      fromMap: (data) => Pet.fromJson(data),
    );
  }

  Future<BaseResponse<List<HealthPlanResponse>>> getHealthPlans() async {
    final response = await get(getHealthPlansPath);
    return BaseResponse.createList(
      response: response,
      fromMap: (data) => HealthPlanResponse.fromMap(data),
    );
  }
}
