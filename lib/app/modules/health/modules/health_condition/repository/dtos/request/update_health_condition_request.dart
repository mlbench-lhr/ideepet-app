import 'dart:convert';

import 'package:idee_pet/app/app.dart';

class UpdateHealthConditionRequest {
  final String condition;
  final String severity;
  final DateTime date;

  UpdateHealthConditionRequest(this.condition, this.severity, this.date);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'health_condition': condition,
      'health_severity': parseSeverityHealth(severity).name,
      'health_date': formatDateTimeToUTC(date),
    };
  }

  String toJson() => json.encode(toMap());
}
