import 'package:get/get.dart';
import 'package:idee_pet/lib.dart';

class ViaCepRepository extends GetConnect {
  static const getViaCepPath = 'https://viacep.com.br/ws/';

  @override
  void onInit() {
    super.onInit();

    httpClient.baseUrl = getViaCepPath;
    httpClient.timeout = const Duration(seconds: 10);
  }

  Future<BaseResponse<ViaCepResponse>> getAddress(String cep) async {
    final response = await get('$cep/json/');

    return BaseResponse.create(
      response: response,
      fromMap: (data) => ViaCepResponse.fromMap(data),
    );
  }
}
