import 'package:idee_pet/app/core/core_old/helps/date_time.dart';

class CreateMedicalRecordRequest {
  final String title;
  final DateTime? date;
  final String petId;
  CreateMedicalRecordRequest({
    required this.title,
    this.date,
    required this.petId,
  });

  Map<String, dynamic> toJson() {
    return {
      "description": title,
      "date": date == null ? null : formatDateTimeToUTC(date),
      "pet_id": petId
    };
  }
}
