import 'package:idee_pet/app/core/base/base_response.dart';
import 'package:idee_pet/app/core/repositories/base_repository.dart';
import 'package:idee_pet/app/modules/notifications/notifications.dart';

class NotificationsRepository extends BaseRepository {
  static const String getNotificationsPath = '/notifications';

  Future<BaseResponse<List<GroupNotifications>>> getNotifications() async {
    final response = await get(getNotificationsPath);

    return BaseResponse.createList(
      response: response,
      fromMap: (data) => GroupNotifications.fromJson(data),
    );
  }

  Future<BaseResponse<void>> readNotifications(
      ReadNotificationRequest request) async {
    final response = await patch(
      '$getNotificationsPath/mark/${request.notificationId}',
      {},
    );

    return BaseResponse.create(
      response: response,
    );
  }
}
