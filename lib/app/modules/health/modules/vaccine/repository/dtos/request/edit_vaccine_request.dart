import 'package:idee_pet/app/modules/health/modules/vaccine/repository/dtos/response/vaccine_response.dart';
import 'package:idee_pet/app/core/core_old/helps/date_time.dart';

class EditVaccineRequest {
  String? title;
  String? lote;
  int? weight;
  DateTime? date;
  DateTime? reforce;
  String petId;
  final bool isAdministered;
  VaccineResponse oldData;

  EditVaccineRequest({
    required this.title,
    required this.lote,
    this.weight,
    this.date,
    this.reforce,
    required this.petId,
    required this.isAdministered,
    required this.oldData,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (title != oldData.title) data["title"] = title;
    if (lote != oldData.lote) data["batch"] = lote;
    if (weight != null && weight != oldData.weight) data["weight"] = weight;
    if (date != oldData.date) {
      data["date"] = date == null ? null : formatDateTimeToUTC(date);
    }
    if (reforce != oldData.reforce) {
      data["reinforcementIn"] =
          reforce == null ? null : formatDateTimeToUTC(reforce);
    }
    if (isAdministered != oldData.isAdministered) {
      data["is_administered"] = isAdministered;
    }

    if (data.isNotEmpty) data["type"] = "vaccine";
    if (data.isNotEmpty) data["pet_id"] = petId;

    return data;
  }
}
