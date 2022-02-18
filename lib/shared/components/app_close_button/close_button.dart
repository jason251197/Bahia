import 'package:appclientes/shared/constants/colors.dart';
import 'package:flutter/material.dart';

class XButton extends StatelessWidget {
  const XButton({
    Key key,
    @required this.onDelete,
    this.model,
  }) : super(key: key);

  final Function onDelete;
  final dynamic model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => model != null ? onDelete(model) : onDelete(),
      child: Icon(
        Icons.close,
        size: 20,
        color: AppColors.gray,
      ),
    );
  }
}
