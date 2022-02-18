import 'package:appclientes/shared/common.dart';
import 'package:flutter/material.dart';

class OnSaleTag extends StatelessWidget {
  const OnSaleTag({
    Key key,
    this.paddingH,
    this.fontSize,
    this.text,
    this.paddingV,
    this.color,
    this.fit = false,
  }) : super(key: key);

  final num paddingH;
  final num paddingV;
  final int fontSize;
  final String text;
  final Color color;
  final bool fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? AppColors.yellow,
      alignment: Alignment.center,
      constraints: fit ? BoxConstraints(maxWidth: 55) : null,
      padding: EdgeInsets.symmetric(
          horizontal: paddingH?.toDouble() ?? 0,
          vertical: paddingV?.toDouble() ?? 0),
      child: fit ? FittedBox(child: buildText) : buildText,
    );
  }

  Widget get buildText =>
      Texts.blackBold(text ?? '', fontSize: fontSize?.toDouble() ?? 15);
}
