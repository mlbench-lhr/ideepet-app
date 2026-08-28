
class Breed{
  final String id;
  final String name;
  Breed({required this.id, required this.name,});

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  static Breed get defaultBreed => Breed(id: '', name: '');
}