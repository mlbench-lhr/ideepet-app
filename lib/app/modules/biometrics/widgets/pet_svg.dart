import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idee_pet/app/core/enum/pet_type_enum.dart';

Widget petImage(String path) {
  return SvgPicture.asset(
    path,
    width: double.infinity,
    height: 210,
  );
}

Widget buildPetImage1(PetType type) {
  String imagePath = type == PetType.dog
      ? 'assets/onboarding_biometric/dog1.svg'
      : 'assets/onboarding_biometric/cat1.svg';

  return petImage(imagePath);
}
