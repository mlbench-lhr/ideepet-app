enum PetPersonality {
  op1(
    'Independente',
    'Confiante, assertivo e gosta\nde explorar sozinho.',
    'independente',
  ),
  op2(
    'Sociável',
    'Curioso, amigável e adora\nconhecer novas pessoas e lugares.',
    'sociavel',
  ),
  op3(
    'Afetuoso',
    'Gentil, carinhoso e sempre em\nbusca de atenção e carinho.',
    'afetuoso',
  ),
  op4(
    'Enérgico',
    'Cheio de energia, espontâneo\ne adora brincar.',
    'energico',
  ),
  op5(
    'Tímido',
    'Reservado, cauteloso e\nprefere ambientes calmos.',
    'timido',
  );

  final String title;
  final String subtitle;
  final String json;
  const PetPersonality(this.title, this.subtitle, this.json);

  static List<PetPersonality> fromJsonList(dynamic jsonList) {
    if (jsonList == null || jsonList is! List) {
      return [];
    }

    List<String> stringList = jsonList.map((e) => e.toString()).toList();

    return PetPersonality.values
        .where((personality) => stringList.contains(personality.json))
        .toList();
  }
}
