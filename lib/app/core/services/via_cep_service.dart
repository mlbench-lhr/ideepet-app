import 'package:idee_pet/lib.dart';

class ViaCepService {
  final ViaCepRepository _repository;

  ViaCepService(this._repository);

  Future<ViaCepResponse?> getAddress(String cep) async {
    final response = await _repository.getAddress(cep);
    return response.result;
  }
}

