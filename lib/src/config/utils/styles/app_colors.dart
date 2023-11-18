import 'package:flutter/material.dart';

abstract class AppColors {
  static Color white = const Color(0xffffffff);
  static Color grey = const Color(0xffF5F5F5);
  static Color greyDark = const Color(0xff898989);

  static Color lowPriority = const Color(0xff674fd0);
  static Color primaryColor = const Color(0x990033FF); //0xff4e4edd
  static Color secondaryColor = const Color(0xff282162);
  static Color darkColor = const Color(0xff000036);
  static Color scaffoldColor = const Color(0xff1A1A29);
  static Color appBarColor = const Color(0xff2f2fec);
  static Color primaryLight = const Color(0xff4545ff);
  static Color greenColor = const Color(0xf461df25);
  static Color redColor = const Color(0xf4df2535);
}

extension GetHexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
