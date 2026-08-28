class MedicamentResponse {
  final String id;
  final String title;
  final String lote;
  final double weight;
  final DateTime? date;
  final DateTime? reforce;

  MedicamentResponse({
    required this.id,
    required this.title,
    required this.lote,
    required this.weight,
    this.date,
    this.reforce,
  });

  factory MedicamentResponse.fromJson(Map<String, dynamic> json) {
    return MedicamentResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      lote: json['batch'] as String,
      weight: (json['weight'] as num).toDouble(),
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      reforce: json['reinforcementIn'] != null
          ? DateTime.parse(json['reinforcementIn'])
          : null,
    );
  }

  factory MedicamentResponse.empty() {
    return MedicamentResponse(
      id: '',
      title: '',
      lote: '',
      weight: 0.0,
      date: null,
      reforce: null,
    );
  }
}
