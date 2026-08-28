import 'package:idee_pet/lib.dart';

class OsmService {
  final OsmRepository _repository;

  OsmService(this._repository);

  Future<OsmResponse?> getCoordinates(OsmRequest request) async {
    final response = await _repository.getCoordinates(request);
    if (response.result != null) {
      return response.result!;
    }
    return null;
  }
}
