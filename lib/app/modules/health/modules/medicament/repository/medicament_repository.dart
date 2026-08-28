import 'package:idee_pet/app/app.dart';

class MedicamentRepository extends BaseRepository {
  static const String getMedicamentsPath = '/medicines';
  // static const String patchHealthPlanPath = '/pets';

  Future<BaseResponse<List<MedicamentResponse>>> getMedicaments(
      MedicamentRequest request) async {
    final response =
        await get('$getMedicamentsPath/${request.petId}/?type=medicine');

    return BaseResponse.createList(
      response: response,
      fromMap: (data) => MedicamentResponse.fromJson(data),
    );
  }

  Future<BaseResponse<void>> deleteMedicaments(
      DeleteMedicamentRequest request) async {
    final response = await delete('$getMedicamentsPath/${request.id}');

    return BaseResponse.create(
      response: response,
    );
  }

  Future<BaseResponse<void>> createMedicament(
      CreateMedicamentRequest request) async {
    final response = await post(getMedicamentsPath, request.toJson());

    return BaseResponse.create(
      response: response,
    );
  }
}
