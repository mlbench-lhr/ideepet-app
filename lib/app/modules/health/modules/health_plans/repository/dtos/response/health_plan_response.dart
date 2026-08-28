class HealthPlanResponse {
  final String id;
  final String name;
  final bool isOther;
  bool isSelected = false;
  HealthPlanResponse({
    required this.id,
    required this.name,
    required this.isOther,
    required this.isSelected,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isOther': isOther,
      'isSelected': isSelected,
    };
  }

  factory HealthPlanResponse.fromMap(Map<String, dynamic> map) {
    return HealthPlanResponse(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      isOther: map['isOther'] ?? false,
      isSelected: map['isSelected'] ?? false,
    );
  }

  factory HealthPlanResponse.empty() => HealthPlanResponse.fromMap({'': ''});
}
