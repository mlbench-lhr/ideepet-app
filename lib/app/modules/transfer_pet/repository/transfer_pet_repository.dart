import 'package:get/get.dart';
import 'package:idee_pet/app/modules/transfer_pet/repository/dtos/request/find_tutor_request.dart';
import 'package:idee_pet/app/modules/transfer_pet/repository/dtos/response/find_tutor_response.dart';
import 'package:idee_pet/lib.dart';

class TransferPetRepository extends BaseRepository {
  static const path = '/find-tutor';
  Future<BaseResponse<FindTutorResponse>> findTutor(
    FindTutorRequest request,
  ) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final response = FindTutorResponse.mock();

    return BaseResponse.createCustom(
      success: true,
      result: response,
    );
  }
}
