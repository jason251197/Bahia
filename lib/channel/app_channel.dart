import 'package:flutter/services.dart';

class AppChannel {
  static const KUSHKI_EVN = "kushki.payment/channel";
  static const SUBS_TOKEN = "subs_token";
  static const GEN_TOKEN = "gen_token";

  static const platform = const MethodChannel(KUSHKI_EVN);

  static Future saveCard(Map<String, dynamic> card) async =>
      await platform.invokeMethod(SUBS_TOKEN, card);

  static Future createToken(Map<String, dynamic> card) async =>
      await platform.invokeMethod(GEN_TOKEN, card);
}
