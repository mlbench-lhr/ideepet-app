class PetFood {
  static const List<String> options = [
    'Ração seca',
    'Ração úmida',
    'Petiscos desidratados',
    'Alimentação natural',
  ];

  static List<String> fromJsonList(dynamic jsonList) {
    if (jsonList == null || jsonList is! List) {
      return [];
    }

    return jsonList.map((e) => e.toString()).toList();
  }
}
