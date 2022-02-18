import 'package:flutter/material.dart';

class AppIcon {
  static const String add = "assets/img/add_plus.png";
  static const String remove = "assets/img/remove.png";

  static const String alert = "assets/img/alert.png";
  static const String calendar = "assets/img/calendar.png";
  static const String close = "assets/img/close.png";

  static const String facebook = "assets/img/facebook.png";
  static const String apple = "assets/img/apple.png";
  static const String google = "assets/img/google.png";

  static const String home = "assets/img/home.png";
  static const String lookup = "assets/img/lookup.png";
  static const String mastercard = "assets/img/mastercard.png";
  static const String defaultcard = "assets/img/defaultcard.png";
  static const String americanExpress = "assets/img/american-express.png";
  static const String dinersClub = "assets/img/diners_club.png";
  static const String order = "assets/img/order.png";
  static const String plus = "assets/img/plus.png";
  static const String save = "assets/img/save.png";
  static const String ship = "assets/img/ship.png";
  static const String visa = "assets/img/visa.png";
  static const String location = "assets/img/location.png";
  static const String edit = "assets/img/edit.png";

  static const String lock = "assets/img/lock_w_color.png";
  static const String phone = "assets/img/phone.png";
  static const String door = "assets/img/door_open.png";

  static const String instagram = "assets/img/Instagram.png";
  static const String phone2 = "assets/img/phone2.png";

  static Widget path(String icon,
          {num width, num height, Color color, num size}) =>
      Image(
        color: color,
        image: AssetImage(icon ?? ''),
        width: size ?? width ?? 25,
        height: size ?? height ?? 25,
      );

  static String getCardType(String card) {
    if (card == "VI") return AppIcon.visa;
    if (card == "MC") return AppIcon.mastercard;
    if (card == "AM") return AppIcon.americanExpress;
    if (card == "DC") return AppIcon.dinersClub;
    //if (visaValidator(card)) return AppIcon.visa;
    //if (masterCardValidator(card)) return AppIcon.mastercard;
    return defaultcard;
  }
}
