class FindTutorRequest {
  final String email;

  FindTutorRequest({required this.email});

  Map<String, dynamic> toMap() => {'email': email};
}
