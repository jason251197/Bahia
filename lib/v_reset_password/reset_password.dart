import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/components/app_logo_w_name/app_logo_w_name.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:appclientes/shared/keys/global_keys.dart';
import 'package:appclientes/v_reset_password/controller/reset_controller.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double myWidth = width * 0.34;
    return AppView(
      child: SingleChildScrollView(
        child: Container(
          height: 500,//MediaQuery.of(context).size.height * 0.7,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: AppKeys.forgotFormKey,
              child: Column(
                children: [
                  Spacer(),
                  LogoWithName(word: "¿Olvidaste tu contraseña?"),
                  _buildMessage,
                  FormInput(
                    icon: Icon(Icons.mail),
                    hintText: "Correo electrónico",
                    textInputType: TextInputType.emailAddress,
                    controller: FormController.emailForgotController,
                    validator: emailValidator,
                  ),
                  Padding(
                    padding: EdgeInset.vertical(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Buttons.lightGray("atrás",
                            width: myWidth,
                            onClick: () => Navigator.pop(context)),
                        Buttons.yellow(
                          "Envía",
                          width: myWidth,
                          onClick: () async =>
                              await ResetPasswordController.validateEmail()
                                  .then((value) =>
                                      value ? Navigator.pop(context) : null),
                        ),
                      ],
                    ),
                  ),
                  //Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding get _buildMessage {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Texts.blackLight(
          "Ingresa tu correo electrónico para recuperar tu contraseña",
          textAlign: TextAlign.center,
          fontSize: 18),
    );
  }
}
