class FoodRequest {
  final String id;
  final List<String> foods;

  FoodRequest({
    required this.id,
    required this.foods,
  });

  Map<String, dynamic> toJson() {
    return {
      'food': foods,
    };
  }
}
