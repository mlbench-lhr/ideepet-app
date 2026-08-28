
class BreedResponse{
  final String id;
  final String name;
  BreedResponse({required this.id, required this.name,});

  factory BreedResponse.fromJson(Map<String, dynamic> json) {
    return BreedResponse(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  static BreedResponse get defaultBreed => BreedResponse(id: '', name: '');
}