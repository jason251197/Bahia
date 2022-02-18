import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/components/app_logo_w_name/app_logo_w_name.dart';
import 'package:appclientes/shared/keys/global_keys.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'controller/register_controller.dart';
import 'data/register_data.dart';
import 'package:appclientes/v_login/content/terminosycondiciones.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppView(
        child: Padding(
      padding: EdgeInset.horizontal(30),
      child: Form(
        key: AppKeys.registerFormKey,
        child: ListView(
          children: [
            LogoWithName(word: "Registro"),
            for (Map input in inputsData)
              _buildInputWSpacer(
                  icon: input["icon"],
                  hintText: input["hintText"],
                  validator: input["validator"],
                  controller: input["controller"],
                  textInputType: input["textInputType"],
                  textCapitalization: input["textCapitalization"],
                  obscureText: input["obscureText"],
                  inputFormatters:
                      List<TextInputFormatter>.from(input["inputFormatters"])),
            _buildTerms,
            _buildButtons(context),
          ],
        ),
      ),
    ));
  }

  Widget _buildInputWSpacer({
    Widget icon,
    String Function(String) validator,
    String hintText,
    TextEditingController controller,
    TextInputType textInputType,
    TextCapitalization textCapitalization,
    bool obscureText,
    List<TextInputFormatter> inputFormatters,
  }) =>
      Padding(
        padding: EdgeInset.vertical(5.0),
        child: FormInput(
          key: Key(hintText),
          icon: icon,
          hintText: hintText,
          textInputType: textInputType,
          validator: validator,
          controller: controller,
          obscureText: obscureText, //hintText.contains(CConsts.password),
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
        ),
      );

  Widget get _buildTerms {
    return Container(
      padding: EdgeInset.vertical(8),
      child: TermsyConditions(),
    );
  }

  Widget _buildButtons(context) {
    double width = MediaQuery.of(context).size.width;
    double myWidth = width * 0.30;
    return Container(
      margin: EdgeInset.vertical(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Buttons.lightGray(
            "atrás",
            width: myWidth,
            paddingH: 10,
            onClick: () => Navigator.pop(context),
          ),
          Buttons.yellow(
            "Regístrate",
            width: myWidth,
            paddingH: 10,
            onClick: () => RegisterController.registerAccount()
                .then((value) => value ? Navigator.pop(context) : null),
          ),
        ],
      ),
    );
  }
}
