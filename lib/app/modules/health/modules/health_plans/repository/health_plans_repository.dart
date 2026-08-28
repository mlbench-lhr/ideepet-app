import 'package:idee_pet/app/app.dart';

class HealthPlansRepository extends BaseRepository {
  static const String getHealthPlansPath = '/health-plans';
  static const String patchHealthPlanPath = '/pets';

  Future<BaseResponse<List<HealthPlanResponse>>> getHealthPlans() async {
    final response = await get(getHealthPlansPath);
    return BaseResponse.createList(
      response: response,
      fromMap: (data) => HealthPlanResponse.fromMap(data),
    );
  }

  Future<BaseResponse<Pet>> updateHealthPlan(
      final UpdateHealthPlanRequest request) async {
    final petId = request.petId;
    final healthPlanId = request.planId;
    final heatlPlanRequest = {
      'health_plan_id': healthPlanId,
    };
    final response = await patch(
      '$patchHealthPlanPath/$petId',
      heatlPlanRequest,
    );

    return BaseResponse.create(
      response: response,
      fromMap: (data) => Pet.fromJson(data),
    );
  }
}
