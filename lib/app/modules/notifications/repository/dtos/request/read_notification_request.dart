import 'dart:convert';

class ReadNotificationRequest {
  final String notificationId;
  ReadNotificationRequest({
    required this.notificationId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notificationId': notificationId,
    };
  }

  factory ReadNotificationRequest.fromMap(Map<String, dynamic> map) {
    return ReadNotificationRequest(
      notificationId: map['notificationId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReadNotificationRequest.fromJson(String source) =>
      ReadNotificationRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
