String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'O campo e-mail é obrigatório.';
  }

  // Expressão regular simplificada e mais legível para validar e-mails.

  final emailRegexImproved = RegExp(
      // Início da string
      r'^'
      // Parte Local: letras, números, ponto, underscore, hífen, MAIS
      r'[a-zA-Z0-9._+-]+'
      // Arroba literal
      r'@'
      // Parte do Domínio: letras, números, hífen, seguido por ponto (pelo menos uma vez)
      r'([a-zA-Z0-9-]+\.)+'
      // TLD (Top-Level Domain): Pelo menos 2 letras
      r'[a-zA-Z]{2,}'
      // Fim da string
      r'$');

  if (!emailRegexImproved.hasMatch(value)) {
    return 'Por favor, insira um endereço de e-mail válido.';
  }

  return '';
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'O campo senha é obrigatório.';
  }

  if (value.length < 8) {
    return 'A senha deve ter pelo menos 8 caracteres.';
  }

  // Verificações individuais para melhor legibilidade e mensagens de erro mais específicas.
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'A senha deve conter pelo menos uma letra maiúscula.';
  }
  if (!value.contains(RegExp(r'[a-z]'))) {
    return 'A senha deve conter pelo menos uma letra minúscula.';
  }
  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'A senha deve conter pelo menos um número.';
  }
  if (!value.contains(RegExp(r'[!@#\$&*~]'))) {
    return 'A senha deve conter pelo menos um caractere especial (!@#\$&*~).';
  }

  return '';
}

String? validateName(String? value) {
  // RegExp que valida:
  // - Apenas letras e espaços
  // - Pelo menos 3 caracteres
  RegExp regex = RegExp(r'^[A-Za-zÀ-ÖØ-öø-ÿ\s]{3,}$');

  if (value == null || value.isEmpty) {
    return 'O campo nome é obrigatório.';
  }

  if (!regex.hasMatch(value)) {
    return 'Insira um nome válido (apenas letras e espaços, mínimo 3 caracteres).';
  }

  return '';
}

String? validatePhone(String? value) {
  // RegExp que valida:
  // - DDD (2 dígitos) + número (9 ou 8 dígitos)
  // - Aceita formatos com ou sem máscara (ex.: (XX) XXXXX-XXXX ou XXXXXXXXXX)
  RegExp regex = RegExp(r'^\(?[1-9]{2}\)?\s?[9]?[0-9]{4}-?[0-9]{4}$');

  if (value == null || value.isEmpty) {
    return '';
  }

  if (!regex.hasMatch(value)) {
    return 'Insira um número de telefone válido (ex.: (11) 91234-5678).';
  }

  return '';
}

String? validateAddress(String? value) {
  // RegExp que valida:
  // - Apenas letras, números, espaços, vírgula e ponto
  // - Pelo menos 5 caracteres
  RegExp regex = RegExp(r'^[A-Za-zÀ-ÖØ-öø-ÿ0-9\s,\.]{5,}$');

  if (value == null || value.isEmpty) {
    return '';
  }

  if (!regex.hasMatch(value)) {
    return 'Insira um endereço válido (apenas letras, números, vírgula, ponto e espaços, mínimo 5 caracteres).';
  }

  return '';
}

String? validatePetName(String? value) {
  // RegExp que valida:
  // - Apenas letras e espaços
  // - Pelo menos 3 caracteres
  RegExp regex = RegExp(r'^[A-Za-zÀ-ÖØ-öø-ÿ\s]{3,}$');

  if (value == null || value.isEmpty) {
    return 'O campo nome é obrigatório.';
  }

  if (!regex.hasMatch(value)) {
    return 'Insira um nome válido (apenas letras e espaços, mínimo 2 caracteres).';
  }

  return '';
}

String? validateDate(String? value) {
  // RegExp para validar data no formato dd/mm/aaaa
  RegExp regex = RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$');

  if (value == null || value.isEmpty) {
    return 'O campo data é obrigatório.';
  }

  if (!regex.hasMatch(value)) {
    return 'Insira uma data válida no formato dd/mm/aaaa.';
  }

  return '';
}

String validateZipCode(String? value) {
  if (value == null || value.isEmpty) {
    return '';
  }

  // Remove caracteres não numéricos.
  final cleanZipCode = value.replaceAll(RegExp(r'[^0-9]'), '');

  // Verifica se o CEP tem 8 dígitos.
  if (cleanZipCode.length != 8) {
    return 'CEP inválido. O CEP deve conter 8 dígitos.';
  }

  return '';
}

String validateState(String? value) {
  if (value == null || value.isEmpty) {
    return '';
  }

  // Lista de UFs válidas (Brasil).
  final validStates = [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ];

  // Converte para maiúsculas para garantir a comparação correta.
  final upperCaseValue = value.toUpperCase();

  if (!validStates.contains(upperCaseValue)) {
    return 'UF inválida. Use uma sigla de UF válida (ex: SP, RJ, MG).';
  }

  return ''; // Retorna null se for válido.
}

String validateCity(String? value) {
  if (value == null || value.isEmpty) {
    return '';
  }

  if (value.length < 2) {
    return 'O nome da cidade deve ter pelo menos 2 caracteres.';
  }

  if (value.length > 80) {
    return 'O nome da cidade não pode ter mais de 80 caracteres';
  }

  //Verifica se não tem números ou caracteres especiais.
  if (value.contains(RegExp(r'[0-9!@#\$&*~%^()_+=\[{\]};:,.?/\\-]'))) {
    return 'A cidade não pode conter números ou caracteres especiais';
  }

  return ''; // Retorna null se for válido.
}

String validateNumber(String? value) {
  if (value == null || value.isEmpty) {
    return '';
  }

  return '';
}
