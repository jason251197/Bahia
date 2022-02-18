import 'package:flutter/material.dart';

import '../common.dart';

class ThemeApp {
  static get getTheme {
    return ThemeData(
      fontFamily: FontFamily.REGULAR_ASSISTANT,
      primaryColor: AppColors.yellow,
      accentColor: AppColors.yellow,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.yellow),
        ),
      ),
    );
  }
}
