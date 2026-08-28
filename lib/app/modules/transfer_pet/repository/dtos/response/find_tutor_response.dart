class FindTutorResponse {
  final String email;
  final String name;
  final String id;
  final String? imageUrl;

  FindTutorResponse({
    required this.email,
    required this.name,
    required this.id,
    this.imageUrl,
  });

  static FindTutorResponse mock() {
    return FindTutorResponse(
      id: '123',
      name: 'João da Silva',
      email: 'joao@email.com',
      imageUrl: 'https://i.pravatar.cc/150?img=5',
    );
  }

  factory FindTutorResponse.fromJson(Map<String, dynamic> json) {
    return FindTutorResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['image_url'],
    );
  }
}
