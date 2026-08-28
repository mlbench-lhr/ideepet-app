import 'package:idee_pet/app/app.dart';

class HealthConditionRepository extends BaseRepository {
  static const String patchHealthConditionsPath = '/pets';

  Future<BaseResponse<Pet>> updateHeathCondition(
      UpdateHealthConditionRequest request, final String petId) async {
    final body = request.toJson();
    final response = await patch('$patchHealthConditionsPath/$petId', body);
    return BaseResponse.create(
      response: response,
      fromMap: (data) => Pet.fromJson(data),
    );
  }
}
