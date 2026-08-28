class FindPetResult {
  final bool exists;
  final String? petId;
  final String? petName;
  FindPetResult({required this.exists, this.petId, this.petName});

  factory FindPetResult.fromJson(Map<String, dynamic> json) {
    return FindPetResult(
      exists: json['exists'] ?? false,
      petId: json['pet_id'],
      petName: json['pet_name'],
    );
  }
}
