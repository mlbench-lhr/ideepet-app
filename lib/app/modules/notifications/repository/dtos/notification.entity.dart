import 'package:idee_pet/app/app.dart';

class NotificationResponse {
  final String id;
  final String title;
  final DateTime date;
  bool isRead;
  final String? deepLink;
  final NotificationType type;

  NotificationResponse({
    required this.id,
    required this.title,
    required this.date,
    required this.isRead,
    this.deepLink,
    required this.type,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date']),
      isRead: json['isRead'] as bool,
      deepLink: json['deepLink'] as String?,
      type: NotificationType.fromString(json['type'] as String),
    );
  }

  factory NotificationResponse.empty() {
    return NotificationResponse(
      id: '',
      title: '',
      date: DateTime.now(),
      isRead: false,
      type: NotificationType.club,
    );
  }
}
