import 'package:appclientes/shared/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:appclientes/shared/constants/urls.dart';
import 'package:appclientes/service/launcher/launcher.dart';

class TermsyConditions extends StatelessWidget {
  const TermsyConditions(
      {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.all(20),
      padding: EdgeInsets.only(left: 0.0, right: 0.0,top: 0.0, bottom: 0.0),
      child: Column(
        children: [
          _terminosyCondiciones
        ],
      ),
    );
  }

  Widget get _terminosyCondiciones {
    return  Padding(
      padding: EdgeInsets.only(left: 0,top: 8.0, bottom: 0),
      child: Column(
        children: [
          RichText(
              softWrap: true,
              textAlign: TextAlign.justify,
              text: TextSpan(style: TextStyle(color: Colors.black, fontFamily: FontFamily.REGULAR_ASSISTANT,),
              children: [
                TextSpan(
                  text: "Al registrarte estás aceptando nuestros  ",
                ),
                TextSpan(
                    text: "términos y condiciones",
                    style: TextStyle(
                      //color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        LauncherService.launchURL(AppURLs.terms2);
                      }
                 ),
                TextSpan(
                  text: " y ",
                ),
                TextSpan(
                    text: "políticas de datos",
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        LauncherService.launchURL(AppURLs.politicas);
                      }
                ),
             ],
            )
          ),
        ],
      ),
    );
  }
}
