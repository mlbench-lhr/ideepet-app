import 'pet_type_enum.dart';

abstract class PetSize {
  String get label;
  String get label2;
  String get svgPath;
  String get json;

  static PetSize fromValue(PetType type, String jsonValue) {
    if (type == PetType.dog) {
      return DogSize.values
          .firstWhere((w) => w.json == jsonValue, orElse: () => DogSize.small);
    } else if (type == PetType.cat) {
      return CatSize.values
          .firstWhere((w) => w.json == jsonValue, orElse: () => CatSize.small);
    }
    throw Exception("Tipo de pet desconhecido para tamanho");
  }
}

enum DogSize implements PetSize {
  small('Pequena', 'Pequeno', 'assets/onboarding/small_dog.svg', 'small'),
  medium('Média', 'Médio', 'assets/onboarding/medium_dog.svg', 'medium'),
  big('Grande', 'Grande', 'assets/onboarding/big_dog.svg', 'big'),
  giant('Gigante', 'Gigante', 'assets/onboarding/giant_dog.svg', 'giant');

  @override
  final String label;
  @override
  final String label2;
  @override
  final String svgPath;
  @override
  final String json;

  const DogSize(this.label, this.label2, this.svgPath, this.json);
}

enum CatSize implements PetSize {
  small('Pequena', 'Pequeno', 'assets/onboarding/small_cat.svg', 'small'),
  medium('Média', 'Médio', 'assets/onboarding/medium_cat.svg', 'medium'),
  big('Grande', 'Grande', 'assets/onboarding/big_cat.svg', 'big'),
  giant('Gigante', 'Gigante', 'assets/onboarding/giant_cat.svg', 'giant');

  @override
  final String label;
  @override
  final String label2;
  @override
  final String svgPath;
  @override
  final String json;

  const CatSize(this.label, this.label2, this.svgPath, this.json);
}
