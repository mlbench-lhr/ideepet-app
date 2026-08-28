import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';

class DialogApp {
  // Dialog com título, subtítulo e um botão "OK"
  static void showOkDialog(BuildContext context, String title, String subtitle,
      void Function() onPressed) {
    AwesomeDialog(
      //barrierColor: Colors.black,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      dialogBackgroundColor: AppColors.background,
      btnOkColor: AppColors.primary,

      context: context,
      dialogType: DialogType.info,
      width: 280,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: title,
      desc: subtitle,
      btnOkOnPress: onPressed,
    ).show();
  }

  // static void showErrorDialog(BuildContext context, String title,
  //     String subtitle, void Function() onPressed) {
  //   AwesomeDialog(
  //     //barrierColor: Colors.black,
  //     dialogBackgroundColor: ColorApp.green,
  //     btnOkColor: ColorApp.greenObscure,

  //     context: context,
  //     dialogType: DialogType.error,
  //     width: 280,
  //     buttonsBorderRadius: const BorderRadius.all(
  //       Radius.circular(2),
  //     ),
  //     headerAnimationLoop: false,
  //     animType: AnimType.bottomSlide,
  //     title: title,
  //     desc: subtitle,
  //     btnOkOnPress: onPressed,
  //   ).show();
  // }

  // Dialog com título, subtítulo e botões "OK" e "Cancelar"

  static void showOkCancelDialog(
    BuildContext context,
    String title,
    String? subtitle,
    void Function() onPressed, {
    Color? background,
    DialogType? dialogType,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    String? btnOkText,
    Color? bttnOkColor,
  }) {
    AwesomeDialog(
      dialogBackgroundColor: background ?? AppColors.background,
      btnCancelColor: AppColors.cardColor,
      btnCancelText: 'Cancelar',
      btnOkColor: bttnOkColor ?? AppColors.primary,
      context: context,
      dialogType: dialogType ?? DialogType.infoReverse,
      animType: AnimType.scale,
      title: title,
      titleTextStyle: titleTextStyle,
      btnOkText: btnOkText,
      desc: subtitle,
      descTextStyle: subtitleTextStyle,
      btnOkOnPress: onPressed,
      btnCancelOnPress: () {},
    ).show();
  }

  // static void showOkCancelDialogSucess(BuildContext context, String title,
  //     String? subtitle, void Function() onPressed) {
  //   AwesomeDialog(
  //           dialogBackgroundColor: ColorApp.grey,
  //           btnCancelColor: Colors.white,
  //           btnCancelText: 'Voltar',
  //           btnOkColor: Colors.green,
  //           context: context,
  //           dialogType: DialogType.success,
  //           animType: AnimType.scale,
  //           title: title,
  //           desc: subtitle,
  //           btnOkOnPress: onPressed,
  //           btnCancelOnPress: () {},
  //           titleTextStyle: const TextStyle(
  //               color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
  //           descTextStyle: const TextStyle(color: Colors.white),
  //           buttonsTextStyle: const TextStyle(color: Colors.black))
  //       .show();
  // }

  // static void dialogNotification(
  //   BuildContext context,
  //   String title,
  //   String? subtitle,
  //   void Function() onPressed,
  //   Color? buttonColor,
  // ) {
  //   AwesomeDialog(
  //     dialogBackgroundColor: ColorApp.green,
  //     btnCancelColor: ColorApp.greenObscure,
  //     btnCancelText: 'Voltar',
  //     btnOkColor: buttonColor ?? Colors.red,
  //     context: context,
  //     dialogType: DialogType.question,
  //     animType: AnimType.topSlide,
  //     title: title,
  //     desc: subtitle,
  //     btnOkOnPress: onPressed,
  //     btnCancelOnPress: () {},
  //   ).show();
  // }
}
