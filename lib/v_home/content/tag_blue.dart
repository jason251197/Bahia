import 'package:appclientes/shared/common.dart';
import 'package:flutter/material.dart';

class BlueTag extends StatelessWidget {
  final String text;
  const BlueTag(
    this.text, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: EdgeInset.appDecoration(
        vertical: 5,
        radius: BorderRadius.circular(7),
        color: AppColors.blue,
        child: Texts.white(text ?? "", fontSize: 15),
      ),
    );
  }
}
