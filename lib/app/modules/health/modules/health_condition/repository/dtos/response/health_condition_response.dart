import 'dart:convert';

class HealthConditionResponse {
  final String condition;
  final DateTime date;
  final String severity;

  HealthConditionResponse(this.condition, this.date, this.severity);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'condition': condition,
      'date': date.millisecondsSinceEpoch,
      'severity': severity,
    };
  }

  factory HealthConditionResponse.fromMap(Map<String, dynamic> map) {
    return HealthConditionResponse(
      map['condition'] as String,
      DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      map['severity'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthConditionResponse.fromJson(String source) =>
      HealthConditionResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
