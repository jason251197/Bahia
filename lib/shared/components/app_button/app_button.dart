import 'package:appclientes/shared/common.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double paddingH;
  final double paddingV;
  final Color color;
  final Color textColor;
  final double fontSize;
  final double width;
  final double height;
  final double radius;
  final EdgeInsets padding;
  final String text;
  final String fontFamily;
  final bool ignorePointer;
  final Function onClick;

  const AppButton({
    Key key,
    this.paddingH,
    this.paddingV,
    this.color,
    this.fontSize,
    this.width,
    this.height,
    this.text,
    this.fontFamily,
    this.textColor,
    this.onClick,
    this.radius,
    this.padding,
    this.ignorePointer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  IgnorePointer(
        ignoring: ignorePointer ?? false,
        child: FlatButton(
            color: color ?? AppColors.yellow,
            padding: padding,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 28.0)),
            onPressed: () => onClick is Function ? onClick() : null,
            child: Container(
              width: width,
              height: height,
              padding: EdgeInsets.symmetric(
                  horizontal: paddingH ?? 20, vertical: paddingV ?? 12),
              child: Text(
                text?.toUpperCase() ?? 'button',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontFamily: fontFamily ?? FontFamily.REGULAR_ASSISTANT,
                  fontSize: fontSize ?? 15,
                  letterSpacing: 1,
                ),
              ),
            ),
       ),
    );
  }
}

class Buttons {
  static AppButton yellow(
    String text, {
    double paddingH,
    double paddingV,
    double fontSize,
    double width,
    double height,
    String fontFamily,
    Function onClick,
    bool disable = false,
  }) =>
      AppButton(
        color: disable ? AppColors.graySoft1 : AppColors.yellow,
        textColor: Colors.black,
        text: text,
        width: width,
        height: height,
        paddingH: paddingH,
        paddingV: paddingV,
        onClick: disable ? null : onClick,
        fontFamily: fontFamily,
        fontSize: fontSize,
        ignorePointer: disable,
      );

  static AppButton blue(
    String text, {
    double paddingH,
    double paddingV,
    double fontSize,
    double width,
    double height,
    String fontFamily,
    Function onClick,
  }) =>
      AppButton(
        color: AppColors.blue,
        onClick: onClick,
        text: text,
        width: width,
        height: height,
        paddingH: paddingH,
        paddingV: paddingV,
        fontFamily: fontFamily,
        fontSize: fontSize,
      );

  static AppButton gray(
    String text, {
    double paddingH,
    double paddingV,
    double fontSize,
    double width,
    double height,
    String fontFamily,
    Function onClick,
  }) =>
      AppButton(
        color: AppColors.darkGray2,
        onClick: onClick,
        text: text,
        width: width,
        height: height,
        paddingH: paddingH,
        paddingV: paddingV,
        fontFamily: fontFamily,
        fontSize: fontSize,
      );

  static AppButton lightGray(
    String text, {
    double paddingH,
    double paddingV,
    double fontSize,
    double width,
    double height,
    String fontFamily,
    Function onClick,
  }) =>
      AppButton(
        color: AppColors.graySoft1,
        textColor: Colors.black,
        onClick: onClick,
        text: text,
        width: width,
        height: height,
        paddingH: paddingH,
        paddingV: paddingV,
        fontFamily: fontFamily,
        fontSize: fontSize,
      );
  static AppButton midGray(
    String text, {
    double paddingH,
    double paddingV,
    double fontSize,
    double width,
    double height,
    String fontFamily,
    Function onClick,
  }) =>
      AppButton(
        color: AppColors.graySoft3,
        textColor: Colors.black,
        onClick: onClick,
        text: text,
        width: width,
        height: height,
        paddingH: paddingH,
        paddingV: paddingV,
        fontFamily: fontFamily,
        fontSize: fontSize,
      );
}
