import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class NotificationsController extends GetxController {
  final NotificationsRepository _repository;
  final NavigationService _navigationService;

  NotificationsController(this._repository, this._navigationService);
  final isLoading = false.obs;

  final groupedNotifications = <GroupNotifications>[].obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    isLoading(true);
    await _getNotifications();
    isLoading(false);
  }

  Future<void> _getNotifications() async {
    final response = await _repository.getNotifications();
    if (response.result != null) {
      groupedNotifications(groupByDate(response.result!));
    }
  }

  Future<void> readNotifications(
      NotificationResponse notificationResponse) async {
    _markNotificationAsRead(notificationResponse);
    final request =
        ReadNotificationRequest(notificationId: notificationResponse.id);
    final response = await _repository.readNotifications(request);
    if (!response.success) {
      _markNotificationsAsUnread(notificationResponse);
      showError(message: 'Erro ao ler notificação');
      return;
    }
    showSuccess(message: 'Notificação lida com sucesso');
  }

  void _markNotificationsAsUnread(NotificationResponse notificationResponse) {
    final notificationId = notificationResponse.id;
    for (var group in groupedNotifications) {
      final notification =
          group.notifications.firstWhereOrNull((n) => n.id == notificationId);
      if (notification != null) {
        notification.isRead = false;
        final index = group.notifications.indexOf(notification);
        group.notifications.removeAt(index);
        group.notifications.insert(index, notification);
        groupedNotifications.refresh();
        return;
      }
    }
  }

  void _markNotificationAsRead(NotificationResponse notificationResponse) {
    final notificationId = notificationResponse.id;
    for (var group in groupedNotifications) {
      final notification =
          group.notifications.firstWhereOrNull((n) => n.id == notificationId);
      if (notification != null) {
        notification.isRead = true;
        final index = group.notifications.indexOf(notification);
        group.notifications.removeAt(index);
        group.notifications.insert(index, notification);
        groupedNotifications.refresh();
        return;
      }
    }
  }

  void back() => _navigationService.back();
}
