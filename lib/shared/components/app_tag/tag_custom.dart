import 'package:appclientes/shared/common.dart';
import 'package:flutter/material.dart';

class CustomTag extends StatelessWidget {
  final String text;
  final double width;
  final Alignment alignment;
  final double spaceVertical;
  final double borderRadius;
  final double fontSize;
  final Color colorBackground;
  final String typeText;

  const CustomTag(
    this.text,
    this.width,
    this.alignment,
    this.spaceVertical,
    this.borderRadius,
    this.fontSize,
    this.colorBackground,
    this.typeText,{
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: EdgeInset.appDecoration(
        vertical: spaceVertical,
        radius: BorderRadius.circular(borderRadius),
        color: colorBackground,
        alignment: alignment,
        child: _buildTypeText(typeText, text, fontSize),
      ),
    );
  }

  _buildTypeText(String typeText, String text, double fontSize){
    if (typeText=="white") return Texts.white(text ?? "", fontSize: fontSize);
    if (typeText=="whiteBold") return Texts.whiteBold(text ?? "", fontSize: fontSize);
    if (typeText=="black") return Texts.black(text ?? "", fontSize: fontSize);
    if (typeText=="blackBold") return Texts.blackBold(text ?? "", fontSize: fontSize);
  }
}
