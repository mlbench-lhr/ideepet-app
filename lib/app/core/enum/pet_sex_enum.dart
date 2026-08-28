enum PetSex {
  macho('Macho', 'male'),
  femea('Fêmea', 'female');

  final String label;
  final String json;

  const PetSex(this.label, this.json);

  String toJson() => json;

  static PetSex fromJson(String value) =>
      PetSex.values.firstWhere((e) => e.json == value);
}
