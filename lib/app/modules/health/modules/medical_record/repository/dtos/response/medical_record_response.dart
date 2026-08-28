class MedicalRecordResponse {
  final String id;
  final String title;
  final DateTime? date;

  MedicalRecordResponse({
    required this.id,
    required this.title,
    this.date,
  });

  factory MedicalRecordResponse.fromJson(Map<String, dynamic> json) {
    return MedicalRecordResponse(
      id: json['id'] as String,
      title: json['description'] as String,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }

  factory MedicalRecordResponse.empty() {
    return MedicalRecordResponse(
      id: '',
      title: '',
      date: null,
    );
  }
}
