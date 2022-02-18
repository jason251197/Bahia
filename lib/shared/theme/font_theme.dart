import 'package:appclientes/shared/constants/colors.dart';
import 'package:appclientes/shared/constants/font-family.dart';
import 'package:flutter/material.dart';

class Texts {
  static Text black(
    String text, {
    num maxLines,
    TextAlign textAlign,
    TextOverflow overflow,
    double textScaleFactor: 1.0,
    double fontSize = 14,
    FontStyle fontStyle,
    double letterSpacing = 0.8,
    double wordSpacing,
    TextDecoration decoration,
    Color color,
  }) =>
      Text(
        text ?? '',
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.visible,
        textScaleFactor: 1.0,
        style: TextStyle(
          color: color ?? AppColors.black,
          fontFamily: FontFamily.REGULAR_ASSISTANT,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          decoration: decoration,
        ),
      );

  static Text blackBold(
    String text, {
    num maxLines,
    TextAlign textAlign,
    TextOverflow overflow,
    double textScaleFactor: 1.0,
    double fontSize = 14,
    FontStyle fontStyle,
    double letterSpacing = 0.8,
    double wordSpacing,
    TextDecoration decoration,
    Color color,
  }) =>
      Text(
        text ?? '',
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.visible,
        textScaleFactor: 1.0,
        style: TextStyle(
          color: color ?? AppColors.black,
          fontFamily: FontFamily.BOLD_ASSISTANT,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          decoration: decoration,
        ),
      );

  static Text blackLight(
    String text, {
    num maxLines,
    TextAlign textAlign,
    TextOverflow overflow,
    double textScaleFactor: 1.0,
    double fontSize = 14,
    FontStyle fontStyle,
    double letterSpacing = 0.8,
    double wordSpacing,
    TextDecoration decoration,
    Color color,
  }) =>
      Text(
        text ?? '',
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.visible,
        textScaleFactor: 1.0,
        style: TextStyle(
          color: color ?? AppColors.black,
          fontFamily: FontFamily.LIGHT_ASSISTANT,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          decoration: decoration,
        ),
      );

  static Text white(
    String text, {
    num maxLines,
    TextAlign textAlign,
    TextOverflow overflow,
    double textScaleFactor: 1.0,
    double fontSize = 14,
    FontStyle fontStyle,
    double letterSpacing = 0.8,
    double wordSpacing,
    TextDecoration decoration,
    Color color,
  }) =>
      Text(
        text ?? '',
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.visible,
        textScaleFactor: 1.0,
        style: TextStyle(
          color: color ?? Colors.white,
          fontFamily: FontFamily.REGULAR_ASSISTANT,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          decoration: decoration,
        ),
      );

  static Text whiteBold(
    String text, {
    num maxLines,
    TextAlign textAlign,
    TextOverflow overflow,
    double textScaleFactor: 1.0,
    double fontSize = 14,
    FontStyle fontStyle,
    double letterSpacing = 0.8,
    double wordSpacing,
    TextDecoration decoration,
    Color color,
  }) =>
      Text(
        text ?? '',
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.visible,
        textScaleFactor: 1.0,
        style: TextStyle(
          color: color ?? Colors.white,
          fontFamily: FontFamily.BOLD_ASSISTANT,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          decoration: decoration,
        ),
      );

  static Text whiteLight(
    String text, {
    num maxLines,
    TextAlign textAlign,
    TextOverflow overflow,
    double textScaleFactor: 1.0,
    double fontSize = 14,
    FontStyle fontStyle,
    double letterSpacing = 0.8,
    double wordSpacing,
    TextDecoration decoration,
    Color color,
  }) =>
      Text(
        text ?? '',
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.visible,
        textScaleFactor: 1.0,
        style: TextStyle(
          color: color ?? Colors.white,
          fontFamily: FontFamily.LIGHT_ASSISTANT,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          decoration: decoration,
        ),
      );

  static Text yellow(
    String text, {
    num maxLines,
    TextAlign textAlign,
    TextOverflow overflow,
    double textScaleFactor: 1.0,
    double fontSize = 14,
    FontStyle fontStyle,
    double letterSpacing = 0.8,
    double wordSpacing,
    TextDecoration decoration,
    Color color,
  }) =>
      Text(
        text ?? '',
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.visible,
        textScaleFactor: 1.0,
        style: TextStyle(
          color: color ?? AppColors.yellow,
          fontFamily: FontFamily.REGULAR_ASSISTANT,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          decoration: decoration,
        ),
      );

  static Text yellowBold(
    String text, {
    num maxLines,
    TextAlign textAlign,
    TextOverflow overflow,
    double textScaleFactor: 1.0,
    double fontSize = 14,
    FontStyle fontStyle,
    double letterSpacing = 0.8,
    double wordSpacing,
    TextDecoration decoration,
    Color color,
  }) =>
      Text(
        text ?? '',
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.visible,
        textScaleFactor: 1.0,
        style: TextStyle(
          color: color ?? AppColors.yellow,
          fontFamily: FontFamily.BOLD_ASSISTANT,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          decoration: decoration,
        ),
      );

  static Text yellowLight(
    String text, {
    num maxLines,
    TextAlign textAlign,
    TextOverflow overflow,
    double textScaleFactor: 1.0,
    double fontSize = 14,
    FontStyle fontStyle,
    double letterSpacing = 0.8,
    double wordSpacing,
    TextDecoration decoration,
    Color color,
  }) =>
      Text(
        text ?? '',
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.visible,
        textScaleFactor: 1.0,
        style: TextStyle(
          color: color ?? AppColors.yellow,
          fontFamily: FontFamily.LIGHT_ASSISTANT,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          decoration: decoration,
        ),
      );
  static Text gray(
    String text, {
    num maxLines,
    TextAlign textAlign,
    TextOverflow overflow,
    double textScaleFactor: 1.0,
    double fontSize = 14,
    FontStyle fontStyle,
    double letterSpacing = 0.8,
    double wordSpacing,
    TextDecoration decoration,
    Color color,
  }) =>
      Text(
        text ?? '',
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.visible,
        textScaleFactor: 1.0,
        style: TextStyle(
          color: color ?? AppColors.gray,
          fontFamily: FontFamily.REGULAR_ASSISTANT,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          decoration: decoration,
        ),
      );

  static Text grayBold(
    String text, {
    num maxLines,
    TextAlign textAlign,
    TextOverflow overflow,
    double textScaleFactor: 1.0,
    double fontSize = 14,
    FontStyle fontStyle,
    double letterSpacing = 0.8,
    double wordSpacing,
    TextDecoration decoration,
    Color color,
  }) =>
      Text(
        text ?? '',
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.visible,
        textScaleFactor: 1.0,
        style: TextStyle(
          color: color ?? AppColors.gray,
          fontFamily: FontFamily.BOLD_ASSISTANT,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          decoration: decoration,
        ),
      );

  static Text grayLight(
    String text, {
    num maxLines,
    TextAlign textAlign,
    TextOverflow overflow,
    double textScaleFactor: 1.0,
    double fontSize = 14,
    FontStyle fontStyle,
    double letterSpacing = 0.8,
    double wordSpacing,
    TextDecoration decoration,
    Color color,
  }) =>
      Text(
        text ?? '',
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.visible,
        textScaleFactor: 1.0,
        style: TextStyle(
          color: color ?? AppColors.graySoft3,
          fontFamily: FontFamily.LIGHT_ASSISTANT,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          decoration: decoration,
        ),
      );
}
