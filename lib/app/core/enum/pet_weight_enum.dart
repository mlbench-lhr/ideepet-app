import 'package:idee_pet/app/core/enum/pet_type_enum.dart';

abstract class PetWeight {
  String get label;
  int get value;

  static PetWeight fromValue(PetType type, int? value) {
    // Verifica o tipo de pet e retorna o peso correspondente
    if (type == PetType.dog) {
      return DogWeight.values.firstWhere((w) => w.value == value,
          orElse: () => DogWeight.op1); // Retorna DogWeight.op1 como padrão
    } else if (type == PetType.cat) {
      return CatWeight.values.firstWhere((w) => w.value == value,
          orElse: () => CatWeight.op1); // Retorna CatWeight.op1 como padrão
    }

    // Caso o tipo não seja reconhecido (não dog nem cat), retorna DogWeight.op1 como valor padrão
    return DogWeight.op1;
  }
}

enum DogWeight implements PetWeight {
  op1('1 kg', 1),
  op2('2 kg', 2),
  op3('3 kg', 3),
  op4('4 kg', 4),
  op5('5 kg', 5),
  op6('6 kg', 6),
  op7('7 kg', 7),
  op8('8 kg', 8),
  op9('9 kg', 9),
  op10('10 kg', 10),
  op11('11 kg', 11),
  op12('12 kg', 12),
  op13('13 kg', 13),
  op14('14 kg', 14),
  op15('15 kg', 15),
  op16('16 kg', 16),
  op17('17 kg', 17),
  op18('18 kg', 18),
  op19('19 kg', 19),
  op20('20 kg', 20),
  op21('21 kg', 21),
  op22('22 kg', 22),
  op23('23 kg', 23),
  op24('24 kg', 24),
  op25('25 kg', 25),
  op26('26 kg', 26),
  op27('27 kg', 27),
  op28('28 kg', 28),
  op29('29 kg', 29),
  op30('30 kg', 30),
  op31('31 kg', 31),
  op32('32 kg', 32),
  op33('33 kg', 33),
  op34('34 kg', 34),
  op35('35 kg', 35),
  op36('36 kg', 36),
  op37('37 kg', 37),
  op38('38 kg', 38),
  op39('39 kg', 39),
  op40('40 kg', 40),
  op41('41 kg', 41),
  op42('42 kg', 42),
  op43('43 kg', 43),
  op44('44 kg', 44),
  op45('45 kg', 45),
  op46('46 kg', 46),
  op47('47 kg', 47),
  op48('48 kg', 48),
  op49('49 kg', 49),
  op50('50 kg', 50),
  op51('51 kg', 51),
  op52('52 kg', 52),
  op53('53 kg', 53),
  op54('54 kg', 54),
  op55('55 kg', 55),
  op56('56 kg', 56),
  op57('57 kg', 57),
  op58('58 kg', 58),
  op59('59 kg', 59);

  @override
  final String label;

  @override
  final int value;

  const DogWeight(this.label, this.value);
}

enum CatWeight implements PetWeight {
  op1('1 kg', 1),
  op2('2 kg', 2),
  op3('3 kg', 3),
  op4('4 kg', 4),
  op5('5 kg', 5),
  op6('6 kg', 6),
  op7('7 kg', 7),
  op8('8 kg', 8),
  op9('9 kg', 9),
  op10('10 kg', 10),
  op11('11 kg', 11),
  op12('12 kg', 12),
  op13('13 kg', 13),
  op14('14 kg', 14),
  op15('15 kg', 15),
  op16('16 kg', 16),
  op17('17 kg', 17),
  op18('18 kg', 18),
  op19('19 kg', 19),
  op20('20 kg', 19),
  op21('21 kg', 21),
  op22('22 kg', 22),
  op23('23 kg', 23),
  op24('24 kg', 24),
  op25('25 kg', 25),
  op26('26 kg', 26),
  op27('27 kg', 27),
  op28('28 kg', 28),
  op29('29 kg', 29),
  op30('30 kg', 30),
  op31('31 kg', 31),
  op32('32 kg', 32),
  op33('33 kg', 33),
  op34('34 kg', 34),
  op35('35 kg', 35),
  op36('36 kg', 36),
  op37('37 kg', 37),
  op38('38 kg', 38),
  op39('39 kg', 39),
  op40('40 kg', 40),
  op41('41 kg', 41),
  op42('42 kg', 42),
  op43('43 kg', 43),
  op44('44 kg', 44),
  op45('45 kg', 45),
  op46('46 kg', 46),
  op47('47 kg', 47),
  op48('48 kg', 48),
  op49('49 kg', 49),
  op50('50 kg', 50);

  @override
  final String label;

  @override
  final int value;

  const CatWeight(this.label, this.value);
}

PetWeight petWeightfromDouble(PetType type, double? value) {
  int intValue =
      value?.round() ?? 1; // Arredonda o double para o inteiro mais próximo

  if (type == PetType.dog) {
    return DogWeight.values.firstWhere(
      (w) => w.value == intValue,
      orElse: () => DogWeight.op1, // Retorna op1 como padrão
    );
  } else if (type == PetType.cat) {
    return CatWeight.values.firstWhere(
      (w) => w.value == intValue,
      orElse: () => CatWeight.op1,
    );
  }

  return DogWeight.op1;
}
