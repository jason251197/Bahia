import 'package:flutter/material.dart';

import '../../common.dart';

class GrayTopHeader extends StatelessWidget {
  const GrayTopHeader({
    Key key,
    this.back,
    this.child,
    this.text,
  }) : super(key: key);

  final Function back;
  final Widget child;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: AppColors.graySoft1,
      child: child ??
          Stack(
            children: [
              if (back is Function)
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    onPressed: back,
                  ),
                ),
              Center(child: Texts.black(text)),
            ],
          ),
    );
  }
}
