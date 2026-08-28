class RefreshCodeRequest {
  final String code;
  RefreshCodeRequest({
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
    };
  }
}
