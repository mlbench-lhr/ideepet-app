import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';

class AppTextStyles {
  final String fontFamily;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final TextDecoration textDecoration;
  final TextOverflow overflow;

  const AppTextStyles._({
    required this.fontFamily,
    required this.fontWeight,
    required this.fontSize,
    required this.color,
    this.textDecoration = TextDecoration.none,
    this.overflow = TextOverflow.ellipsis,
  });

  factory AppTextStyles.title({
    String fontFamily = 'NewKansas',
    double fontSize = 40.0,
    Color color = AppColors.primary,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return AppTextStyles._(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  factory AppTextStyles.subtitle({
    String fontFamily = 'NewKansas',
    double fontSize = 16,
    Color color = AppColors.fontColorSubtitle,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return AppTextStyles._(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  factory AppTextStyles.subtitleBold({
    String fontFamily = 'NewKansas',
    double fontSize = 15,
    Color color = AppColors.fontColorSubtitle,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return AppTextStyles._(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  factory AppTextStyles.poppinsExtraBold({
    String fontFamily = 'Poppins',
    double fontSize = 28,
    Color color = AppColors.fontColorSubtitle,
    FontWeight fontWeight = FontWeight.w800,
  }) {
    return AppTextStyles._(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  factory AppTextStyles.poppinsSemiBold({
    String fontFamily = 'Poppins',
    double fontSize = 17,
    Color color = AppColors.fontColorSubtitle,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return AppTextStyles._(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  factory AppTextStyles.poppinsMedium({
    String fontFamily = 'Poppins',
    double fontSize = 13,
    Color color = AppColors.fontColorSubtitle,
    FontWeight fontWeight = FontWeight.w400,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    return AppTextStyles._(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      overflow: overflow,
    );
  }
  factory AppTextStyles.poppinsLight({
    String fontFamily = 'Poppins',
    double fontSize = 13,
    Color color = AppColors.fontColorSubtitle,
    FontWeight fontWeight = FontWeight.w200,
  }) {
    return AppTextStyles._(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  factory AppTextStyles.mulishBold({
    String fontFamily = 'Mulish',
    double fontSize = 13,
    Color color = AppColors.fontColorSubtitle,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return AppTextStyles._(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  factory AppTextStyles.mulishRegular({
    String fontFamily = 'Mulish',
    double fontSize = 13,
    Color color = AppColors.grey,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return AppTextStyles._(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      textDecoration: decoration,
    );
  }

  factory AppTextStyles.robotoMedium({
    String fontFamily = 'Roboto',
    double fontSize = 13,
    Color color = AppColors.grey,
    FontWeight fontWeight = FontWeight.w500,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return AppTextStyles._(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      textDecoration: decoration,
    );
  }

  factory AppTextStyles.montserratSemiBold({
    String fontFamily = 'Montserrat',
    double fontSize = 13,
    Color color = AppColors.grey,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return AppTextStyles._(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      textDecoration: decoration,
    );
  }

  TextStyle get style {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      decoration: textDecoration,
      height: 1.2,
      overflow: overflow,
    );
  }
}
