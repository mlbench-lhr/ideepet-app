import 'package:idee_pet/lib.dart';

class ProfileRepository extends BaseRepository {
  static const pathDeleteAccount = '/users/';
  Future<BaseResponse<void>> deleteUser(String id) async {
    print('@@@ id: $id');
    final response = await delete('$pathDeleteAccount$id');
    print('@@@ response: $response');
    return BaseResponse.create(response: response);
  }
}
