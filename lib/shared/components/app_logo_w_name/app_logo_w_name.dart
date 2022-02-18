import 'package:flutter/material.dart';

import '../../common.dart';

class LogoWithName extends StatelessWidget {
  final String word;
  final Function onPress;

  const LogoWithName({
    Key key,
    this.word,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onDoubleTap: () {
            if (onPress is Function) onPress();
          },
          child: Center(
            child: Image(
              image: AssetImage(AppImages.LOGO_1),
              height: 120,
              width: 120,
            ),
          ),
        ),
        Texts.blackLight(
          word ?? "¡Hola!",
          fontSize: 28,
        )
      ],
    );
  }
}
