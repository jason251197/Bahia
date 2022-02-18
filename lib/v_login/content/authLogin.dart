import 'dart:io';

import 'package:appclientes/service/auth/auth_service.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/v_login/controller/login_controller.dart';
import 'package:appclientes/v_login/data/auth_options_data.dart';
import 'package:flutter/material.dart';
import 'package:appclientes/v_login/content/terminosycondiciones.dart';

class AuthLogin extends StatelessWidget {
  final bool cartRedirect;
  const AuthLogin(
    this.cartRedirect,{
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.all(20),
      padding: EdgeInsets.only(left: 20.0, right: 20.0,top: 5.0, bottom: 0.0),
      child: Column(
        children: [
          Text("- o ingresa con -"),
          for (Map _map in authOptions) _buildAuthOption(_map),
          TermsyConditions(),
          _buildRegister(context)
        ],
      ),
    );
  }

  Widget _buildRegister(var context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("¿No tienes una cuenta?"),
          GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
                LoginController.goToRegister();
              },
              child: Texts.yellowBold("Regístrate"))
        ],
      ),
    );
  }

  Widget _buildAuthOption(Map data) {
    if (data is! Map) return Container();
    if (Platform.isAndroid && data["type"] == AUTH_TYPE.APPLE)
      return Container();
    return GestureDetector(
      onTap: () => LoginController.oAuth(data["type"],cartRedirect),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image(
                image: AssetImage(data["icon"]),
                width: 20,
                height: 20,
              ),
              Expanded(
                child: Text(
                  data["title"],
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
