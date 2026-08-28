import 'package:idee_pet/app/app.dart';
import 'package:idee_pet/app/modules/health/modules/vaccine/repository/dtos/request/edit_vaccine_request.dart';

class VaccineRepository extends BaseRepository {
  static const String getVaccinesPath = '/medicines';
  // static const String patchHealthPlanPath = '/pets';

  Future<BaseResponse<List<VaccineResponse>>> getVaccines(
      VaccineRequest request) async {
    final response =
        await get('$getVaccinesPath/${request.petId}/?type=vaccine');

    return BaseResponse.createList(
      response: response,
      fromMap: (data) => VaccineResponse.fromJson(data),
    );
  }

  Future<BaseResponse<void>> deleteVaccines(
      DeleteVaccineRequest request) async {
    final response = await delete('$getVaccinesPath/${request.id}');

    return BaseResponse.create(
      response: response,
    );
  }

  Future<BaseResponse<void>> createVaccine(CreateVaccineRequest request) async {
    final response = await post(getVaccinesPath, request.toJson());

    return BaseResponse.create(
      response: response,
    );
  }

  Future<BaseResponse<void>> editVaccine(EditVaccineRequest request) async {
    final response =
        await patch('$getVaccinesPath/${request.oldData.id}', request.toJson());

    return BaseResponse.create(
      response: response,
    );
  }
}
