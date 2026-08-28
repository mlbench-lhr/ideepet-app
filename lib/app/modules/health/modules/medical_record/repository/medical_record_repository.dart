import 'package:idee_pet/app/app.dart';

class MedicalRecordRepository extends BaseRepository {
  static const pathMedicalRecord = '/medical-record';

  Future<BaseResponse<List<MedicalRecordResponse>>> getMedicalRecord(
      GetMedicalRecordRequest request) async {
    final response = await get('$pathMedicalRecord/${request.petId}');
    return BaseResponse.createList(
      response: response,
      fromMap: (data) => MedicalRecordResponse.fromJson(data),
    );
  }

  Future<BaseResponse<CreateMedicalRecordResponse>> createMedicalRecord(
      CreateMedicalRecordRequest request) async {
    final response = await post(
      pathMedicalRecord,
      request.toJson(),
    );
    return BaseResponse.create(
      response: response,
      fromMap: (data) => CreateMedicalRecordResponse.fromMap(data),
    );
  }

  Future<BaseResponse<void>> deleteMedicalRecord(String id) async {
    final response = await delete(pathMedicalRecord);
    return BaseResponse.create(response: response);
  }
}
