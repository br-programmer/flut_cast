import 'package:flutter/material.dart';

class Palette {
  const Palette._();

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;
  static const Color red = Color(0xFFFF5258);
  static const Color dark = Color(0xFF181818);
  static const Color grey = Color(0xFF252525);
  static const Color background = Color(0xFF2A303B);
  static const Color skyBlue = Color(0xFF6EAED3);
  static const Color grey10 = Color(0xFF455160);
  static const Color yellow = Color(0xFFEDD41C);
  static const Color orange5 = Color(0xFFEAA32B);
  static const Color orange10 = Color(0xFFEA7B2E);

  static const colors = [
    white,
    transparent,
    red,
    dark,
  ];

  static const gradient = [
    Color(0XFF3665E9),
    Color(0XFF3B73EC),
    Color(0XFF3F7DED),
    Color(0XFF4487ED),
    Color(0XFF4890EF),
    Color(0XFF4C9AF1),
    Color(0XFF51A5F3),
    Color(0XFF54ACF3),
    Color(0XFF59B7F5),
    Color(0XFF5DBEF7),
  ];

  static List<Color> progressBarColors = [
    Colors.red.withOpacity(1),
    Colors.red.withOpacity(0.54),
    Colors.green,
    Colors.white,
  ];
}
