import 'package:flutter/material.dart';

class EdgeInset {
  static EdgeInsets horizontal(num pixels) =>
      EdgeInsets.symmetric(horizontal: pixels.toDouble());
  static EdgeInsets vertical(num pixels) =>
      EdgeInsets.symmetric(vertical: pixels.toDouble());
  static EdgeInsets left(num pixels) =>
      EdgeInsets.only(left: pixels.toDouble());
  static EdgeInsets rigth(num pixels) =>
      EdgeInsets.only(right: pixels.toDouble());
  static EdgeInsets bottom(num pixels) =>
      EdgeInsets.only(bottom: pixels.toDouble());
  static EdgeInsets top(num pixels) => EdgeInsets.only(top: pixels.toDouble());

  static Widget appPadding(
      {Widget child, double horizontal, double, vertical}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontal ?? 10, vertical: vertical ?? 0),
      child: child ?? Container(),
    );
  }

  static Widget appDecoration({
    Widget child,
    double horizontal,
    double vertical,
    double marginH,
    double marginV,
    Border border,
    BorderRadius radius,
    Color color,
    Alignment alignment,
  }) {
    return Container(
      alignment: alignment,
      margin: EdgeInsets.symmetric(
          horizontal: marginH ?? 0, vertical: marginV ?? 0),
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        border: border,
        borderRadius: radius ?? BorderRadius.zero,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: horizontal ?? 10, vertical: vertical ?? 0),
      child: child ?? Container(),
    );
  }
}
