enum PetAge {
  op0('Meses', 0),
  op1('1 ano', 1),
  op2('2 anos', 2),
  op3('3 anos', 3),
  op4('4 anos', 4),
  op5('5 anos', 5),
  op6('6 anos', 6),
  op7('7 anos', 7),
  op8('8 anos', 8),
  op9('9 anos', 9),
  op10('10 anos', 10),
  op11('11 anos', 11),
  op12('12 anos', 12),
  op13('13 anos', 13),
  op14('14 anos', 14),
  op15('15 anos', 15),
  op16('16 anos', 16),
  op17('17 anos', 17),
  op18('18 anos', 18),
  op19('19 anos', 19),
  op20('20 anos', 20),
  op21('21 anos', 21),
  op22('22 anos', 22),
  op23('23 anos', 23),
  op24('24 anos', 24),
  op25('25 anos', 25),
  op26('26 anos', 26),
  op27('27 anos', 27),
  op28('28 anos', 28),
  op29('29 anos', 29),
  op30('30 anos', 30),
  op31('31 anos', 31),
  op32('32 anos', 32),
  op33('33 anos', 33),
  op34('34 anos', 34),
  op35('35 anos', 35),
  op36('36 anos', 36),
  op37('37 anos', 37),
  op38('38 anos', 38),
  op39('39 anos', 39),
  op40('40 anos', 40);

  final String label;
  final int value;

  const PetAge(this.label, this.value);

  static PetAge fromValue(String value) {
    try {
      int intValue = int.parse(value);
      return PetAge.values.firstWhere(
        (age) => age.value == intValue,
        orElse: () => PetAge.op0,
      );
    } catch (e) {
      return PetAge.op0;
    }
  }
}
