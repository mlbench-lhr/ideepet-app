import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgsAccountGeneral extends StatelessWidget {
  final String logoPath;
  final double width;
  final double height;
  static const String base = 'assets/account_general';
  const SvgsAccountGeneral._({
    required this.logoPath,
    required this.width,
    required this.height,
  });

  factory SvgsAccountGeneral.calendar({double width = 8, double height = 8}) {
    return SvgsAccountGeneral._(
      logoPath: '$base/calendar.svg',
      width: width,
      height: height,
    );
  }

  factory SvgsAccountGeneral.config({double width = 20, double height = 20}) {
    return SvgsAccountGeneral._(
      logoPath: '$base/config.svg',
      width: width,
      height: height,
    );
  }

  factory SvgsAccountGeneral.info({double width = 20, double height = 20}) {
    return SvgsAccountGeneral._(
      logoPath: '$base/info.svg',
      width: width,
      height: height,
    );
  }

  factory SvgsAccountGeneral.recort({double width = 52, double height = 43}) {
    return SvgsAccountGeneral._(
      logoPath: '$base/recort.svg',
      width: width,
      height: height,
    );
  }

  factory SvgsAccountGeneral.tel({double width = 8, double height = 8}) {
    return SvgsAccountGeneral._(
      logoPath: '$base/tel.svg',
      width: width,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      logoPath,
      width: width,
      height: height,
    );
  }
}
