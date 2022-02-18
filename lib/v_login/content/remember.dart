import 'package:appclientes/v_login/controller/login_controller.dart';
import 'package:flutter/material.dart';

class Remember extends StatefulWidget {
  const Remember({
    Key key,
  }) : super(key: key);

  @override
  _RememberState createState() => _RememberState();
}

class _RememberState extends State<Remember> {
  bool rememberMe = false;

  // void _onRememberMeChanged(bool newValue) => setState(() {
  //       rememberMe = newValue;
  //       if (rememberMe) {
  //       } else {}
  //     });
  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.symmetric(vertical: 20.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                // child: Checkbox(
                //   activeColor: AppColors.darkGray2,
                //   value: rememberMe,
                //   onChanged: _onRememberMeChanged,
                // ),
              ),
              SizedBox(width: 10),
              // Text("Recordar")
            ],
          ),
          GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                LoginController.goToForgot();
              },
              child: Text("Olvidé mi contraseña"))
        ],
      ),
    );
  }
}
