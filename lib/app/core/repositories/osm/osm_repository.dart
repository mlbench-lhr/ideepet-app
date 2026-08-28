import 'dart:math';

import 'package:idee_pet/lib.dart';

class OsmRepository extends BaseRepository {
  OsmRepository() : super(allowBypass: true);

  @override
  void onInit() {
    super.onInit();
    //httpClient.timeout = const Duration(seconds: 10);
    httpClient.baseUrl = 'https://nominatim.openstreetmap.org';
  }

  Future<BaseResponse<OsmResponse?>> getCoordinates(OsmRequest request) async {
    final response = await get('/search?q=${request.toString()}&format=json');

    final result = response.body != null &&
            response.body is List &&
            response.body.isNotEmpty
        ? OsmResponse.fromMap(response.body.first)
        : null;

    return BaseResponse.createCustom(
      success: response.statusCode! < 200,
      errorMessages: [],
      result: result,
    );
  }
}
