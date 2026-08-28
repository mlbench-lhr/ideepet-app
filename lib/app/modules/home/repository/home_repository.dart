import 'dart:async';

import 'package:idee_pet/app/app.dart';

class HomeRepository extends BaseRepository {
  static const getPetsPath = '/pets';
  static const String getNotificationsPath = '/notifications';

  Future<BaseResponse<List<Pet>>> getPets() async {
    redirect = false;

    final response = await get('$getPetsPath?page=1&limit=500');

    redirect = true;
    return BaseResponse.createList(
      response: response,
      fromMap: (data) => Pet.fromJson(data),
    );
  }

  Future<BaseResponse<int>> getIntNotifications() async {
    final response = await get(getNotificationsPath);

    return BaseResponse.create<int>(
      response: response,
      fromMap: (data) {
        final list = (data as List)
            .map((json) => GroupNotifications.fromJson(json))
            .toList();

        final count = list
            .expand((group) => group.notifications)
            .where((notification) => !notification.isRead)
            .length;

        return count;
      },
    );
  }
}
