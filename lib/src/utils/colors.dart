import 'package:flutter/material.dart';

class AppColors {
  // ignore: non_constant_identifier_names
  static final MaterialColor PRIMARY_COLOR = _factoryColor(0xff1CC88A);

  // ignore: non_constant_identifier_names
  static final MaterialColor PRIMARY_LIGHT = _factoryColor(0xff6E8790);

  // ignore: non_constant_identifier_names
  static final MaterialColor PRIMARY_Medium_LIGHT = _factoryColor(0xff335763);

  // ignore: non_constant_identifier_names
  static final MaterialColor SEC_COLOR = _factoryColor(0xffE5C0A0);

  // ignore: non_constant_identifier_names
  static final MaterialColor RED = _factoryColor(0xffD94539);

  // ignore: non_constant_identifier_names
  static final MaterialColor LIGHT_GREY = _factoryColor(0xffd8d8d8);

  // ignore: non_constant_identifier_names
  static final MaterialColor DARKBLACK = _factoryColor(0xff424242);

  // ignore: non_constant_identifier_names
  static final MaterialColor WHITE = _factoryColor(0xffffffff);

  // ignore: non_constant_identifier_names
  static final MaterialColor GREEN = _factoryColor(0xff76BA3F);

  // ignore: non_constant_identifier_names
  static final MaterialColor LIGHT_BLACK = _factoryColor(0xff5F5F5F);

  // ignore: non_constant_identifier_names
  static final MaterialColor LIGHT_BG = _factoryColor(0xffEFEEF3);

  static MaterialColor hex(String hex) =>
      AppColors._factoryColor(AppColors._getColorHexFromStr(hex));

  static MaterialColor _factoryColor(int color) {
    return MaterialColor(color, <int, Color>{
      50: Color(color),
      100: Color(color),
      200: Color(color),
      300: Color(color),
      400: Color(color),
      500: Color(color),
      600: Color(color),
      700: Color(color),
      800: Color(color),
      900: Color(color),
    });
  }

  static int _getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        val = 0xFFFFFFFF;
      }
    }
    return val;
  }
}
