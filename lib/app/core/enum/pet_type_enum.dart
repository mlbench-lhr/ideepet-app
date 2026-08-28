import 'package:flutter/material.dart';

enum PetType {
  none('Nenhum', Icons.help_outline, ''),
  dog('Cachorro', Icons.pets, '/breeds/dog'),
  cat('Gato', Icons.pets, '/breeds/cat');

  final String label;
  final IconData icon;
  final String route;

  const PetType(this.label, this.icon, this.route);

  static PetType fromJson(String value) {
    return PetType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => PetType.none,
    );
  }
}
