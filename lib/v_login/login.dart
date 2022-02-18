import 'package:appclientes/shared/components/app_logo_w_name/app_logo_w_name.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:flutter/material.dart';

import 'content/authLogin.dart';
import 'content/loginButtons.dart';
import 'content/remember.dart';
import 'controller/login_controller.dart';

class LoginView extends StatefulWidget {
  final bool doPop;
  final bool cartRedirect;
  LoginView([this.doPop = false, this.cartRedirect = false]);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AppView(
      // resize: false,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Spacer(flex: 2),
                      LogoWithName(onPress: LoginController.fastAuth),
                      Spacer(),
                      _buildForm(loginFormKey),
                      Remember(),
                      Spacer(),
                      LoginButtons(
                        widget.doPop,
                        widget.cartRedirect,
                        onPress: () => loginFormKey.currentState.validate(),
                      ),
                      Spacer(),
                      AuthLogin(widget.cartRedirect),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form _buildForm(loginFormKey) {
    return Form(
      key: loginFormKey,
      child: Column(
        children: [
          FormInput(
            icon: Icon(Icons.mail),
            hintText: "Correo electrónico",
            validator: emailValidator,
            textInputType: TextInputType.emailAddress,
            controller: FormController.emailController,
          ),
          FormInput(
            icon: Icon(Icons.lock),
            hintText: "Contraseña",
            obscureText: true,
            validator: passwordLoginValidator,
            textCapitalization: TextCapitalization.none,
            controller: FormController.passwordController,
          ),
        ],
      ),
    );
  }
}
