class SentDataPet {
  final String? name;
  final String? phone;
  final String? email;
  final String lat;
  final String long;
  final String petId;

  SentDataPet({
    required this.name,
    required this.phone,
    required this.email,
    required this.lat,
    required this.long,
    required this.petId,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'lat': lat,
        'long': long,
        'pet_id': petId,
      };
}
