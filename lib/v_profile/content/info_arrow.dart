import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/components/app_card/app_card.dart';
import 'package:flutter/material.dart';

class InfoArrow extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPress;
  final bool card;
  final bool borderline;
  const InfoArrow({
    Key key,
    this.title,
    this.card = false,
    this.icon,
    this.onPress,
    this.borderline = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (card ?? false)
      return SimpleCard(
          child: Container(
        child: _buildArrow,
      ));
    return _buildArrow;
  }

  Widget get _buildArrow => GestureDetector(
        onTap: onPress,
        child: CardField(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon ?? Icons.phone, color: AppColors.yellow),
                  SizedBox(width: 10),
                  Texts.black(title ?? "text", letterSpacing: 0),
                ],
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.gray,
              ),
            ],
          ),
        ),
      );
}
