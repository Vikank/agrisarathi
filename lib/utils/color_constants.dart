import 'dart:ui';
import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
  'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}


class ColorConstants {
  // static Color lightScaffoldBackgroundColor = Color('#F9F9F9');
  // static Color darkScaffoldBackgroundColor = Color('#2F2E2E');
  static Color fieldNameColor = hexToColor('#00B251');
  static Color textColor = hexToColor('#000000');
  static const Color textFieldBgClr =  Color(0xffF5F5F5);
}
