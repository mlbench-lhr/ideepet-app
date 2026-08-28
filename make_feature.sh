#!/bin/bash

# Solicita o nome da feature.  Validação básica.
while true; do
  read -p "Digite o nome da feature (formato snake_case, ex: minha_feature): " feature_name
  if [[ "$feature_name" =~ ^[a-z]+(_[a-z]+)*$ ]]; then
    break
  else
    echo "Nome inválido. Use snake_case (letras minúsculas e underscores)."
  fi
done

# Cria variáveis intermediárias para os nomes transformados.
feature_name_upper="$(echo "$feature_name" | sed 's/\(^\|_\)\([a-z]\)/\U\2/g')"  # Para UpperCamelCase
feature_name_capitalized="$(echo "$feature_name" | sed 's/^\([a-z]\)/\U\1/')" # Para Capitalized (primeira letra maiúscula)
#echo "$feature_name_upper" # para debugar
#echo "$feature_name_capitalized" # para debugar

# Cria as pastas e arquivos.
base_path="lib/features/$feature_name"  # Caminho completo

# Cria a estrutura de diretórios.
mkdir -p "$base_path/data"
mkdir -p "$base_path/presentation/controller"
mkdir -p "$base_path/presentation/pages"

# Cria o arquivo do controller (MobX).
controller_file="$base_path/presentation/controller/${feature_name}_controller.dart"
cat > "$controller_file" <<EOF
import 'package:mobx/mobx.dart';

part '${feature_name}_controller.g.dart';

class ${feature_name_upper}Controller = _${feature_name_upper}Controller with _\$${feature_name_upper}Controller;

abstract class _${feature_name_upper}Controller with Store {
  // @observable
  // int value = 0;

  // @action
  // void increment() {
  //   value++;
  // }
    //Adicione outras variaveis e metodos aqui
}
EOF

# Cria o arquivo .g.dart (inicialmente vazio - será gerado pelo build_runner).
touch "$base_path/presentation/controller/${feature_name}_controller.g.dart"

# Cria o arquivo da página.
page_file="$base_path/presentation/pages/${feature_name}_page.dart"
cat > "$page_file" <<EOF
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controller/${feature_name}_controller.dart';

class ${feature_name_upper}Page extends StatelessWidget {
  final ${feature_name_upper}Controller _controller = ${feature_name_upper}Controller();

   ${feature_name_upper}Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$feature_name_capitalized'),
      ),
      body: Center(
        // child: Observer(
        //   builder: (_) => Text(
        //     '\${_controller.value}',
        //     style: Theme.of(context).textTheme.headlineMedium,
        //  ),
        //),
      ),
    );
  }
}
EOF

echo "Feature '$feature_name' criada com sucesso em '$base_path'."
echo "Execute 'flutter pub run build_runner build --delete-conflicting-outputs' para gerar o arquivo .g.dart."