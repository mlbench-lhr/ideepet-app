import 'package:idee_pet/app/core/core_old/helps/date_time.dart';

class CreateMedicamentRequest {
  final String title;
  final String lote;
  final int? weight;
  final DateTime? date;
  final DateTime? reforce;
  final String petId;
  CreateMedicamentRequest({
    required this.title,
    required this.lote,
    this.weight,
    this.date,
    this.reforce,
    required this.petId,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "batch": lote,
      "weight": weight,
      "date": date == null ? null : formatDateTimeToUTC(date),
      "reinforcementIn": reforce == null ? null : formatDateTimeToUTC(reforce),
      "type": "medicine",
      "pet_id": petId
    };
  }
}
