import 'package:flutter/material.dart';

class AppColors {
  static const black = Color(0xFF20201E);
  static const orange = Color(0xFFFF7700);
  static const blue = Color(0xFF1D90F5);
  static const turquoise = Color(0xFF1ED4CB);
  static const yellow = Color(0xFFFFD738);
  static const purple = Color(0xFF9C00F9);
  static const gray = Color(0xFF848482);
  static const darkBlue = Color(0xFF2D4155);
  static const darkGray1 = Color(0xFF5C5C5A);
  static const darkGray2 = Color(0xFF707070);
  static const graySoft1 = Color(0xFFF2F2F0);
  static const graySoft2 = Color(0xFFF0F0F0);
  static const graySoft3 = Color(0xFFDEDEDC);
  static const graySoft4 = Color(0xFFFAFAF8);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
