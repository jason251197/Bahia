import 'package:appclientes/shared/common.dart';
import 'package:flutter/material.dart';

class GrayTag extends StatelessWidget {
  final String text;
  const GrayTag(
    this.text, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: EdgeInset.appDecoration(
        vertical: 5,
        radius: BorderRadius.circular(7),
        color: AppColors.graySoft3,
        child: Texts.black(text ?? "10:00 a 13:00 hrs", fontSize: 15),
      ),
    );
  }
}
