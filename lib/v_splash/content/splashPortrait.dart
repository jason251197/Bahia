import 'package:appclientes/shared/components/app_view/app_view.dart';
import 'package:appclientes/shared/constants/index.dart';
import 'package:flutter/material.dart';

AppView get buildSplashPortrait {
  return AppView(
    backgroundColor: AppColors.yellow,
    child: Container(
      alignment: Alignment.center,
      child: Image(
        image: AssetImage(AppImages.LOGO_SPLASH),
        width: 250,
        height: 250,
      ),
    ),
  );
}
