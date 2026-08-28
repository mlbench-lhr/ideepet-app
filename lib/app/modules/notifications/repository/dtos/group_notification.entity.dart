import 'package:idee_pet/app/modules/notifications/repository/dtos/notification.entity.dart';

class GroupNotifications {
  final DateTime date;
  List<NotificationResponse> notifications;

  GroupNotifications({
    required this.date,
    required this.notifications,
  });

  factory GroupNotifications.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate = DateTime.parse(json['date']);

    NotificationResponse notification = NotificationResponse.fromJson(json);

    return GroupNotifications(
      date: parsedDate,
      notifications: [notification],
    );
  }
}
