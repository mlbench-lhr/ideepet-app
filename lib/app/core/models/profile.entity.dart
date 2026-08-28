class Profile {
  final String id;
  String name;
  String email;
  final String? contact;
  String? phone;
  final String? imageUrl;
  String? addressStreet;
  String? addressCity;
  String? addressState;
  String? addressCep;
  String? addressNumber;
  String? addressComplement;
  String? addressNeighborhood;
  String? addressLat;
  String? addressLong;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.contact,
    this.phone,
    this.imageUrl,
    this.addressStreet,
    this.addressCity,
    this.addressState,
    this.addressCep,
    this.addressNumber,
    this.addressComplement,
    this.addressNeighborhood,
    this.addressLat,
    this.addressLong,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] ?? '---',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      contact: json['contact'],
      imageUrl: json['avatar_url'] ?? '',
      phone: json['phone'],
      addressStreet: json['address_street'],
      addressCity: json['address_city'],
      addressState: json['address_state'],
      addressCep: json['address_cep'],
      addressNumber: json['address_number'],
      addressComplement: json['address_complement'],
      addressNeighborhood: json['address_neighborhood'],
      addressLat: json['address_lat'],
      addressLong: json['address_long'],
    );
  }

  factory Profile.empty() => Profile.fromJson({'': ''});

  String firstName() {
    return name.split(' ').first;
  }
}
