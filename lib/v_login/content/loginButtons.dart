import 'package:appclientes/shared/common.dart';
import 'package:appclientes/v_login/controller/login_controller.dart';
import 'package:flutter/material.dart';

class LoginButtons extends StatelessWidget {
  final bool doPop;
  final bool cartRedirect;
  final bool Function() onPress;
  const LoginButtons(
    this.doPop,
    this.cartRedirect, {
    Key key,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double myWidth = width * 0.34;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Buttons.blue(
          "MAS TARDE",
          width: myWidth,
          onClick: doPop ? () => Navigator.pop(context) : LoginController.later,
        ),
        Buttons.yellow("ACCEDE  ", width: myWidth, onClick: () {
          final value = onPress();
          if (value) LoginController.authAccount(cartRedirect);
        }),
      ],
    );
  }
}
