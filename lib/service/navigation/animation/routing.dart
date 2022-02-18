import 'package:flutter/material.dart';

enum ROUT_EFFECT { NORMAL, FADE }

class RouteAnimation {
  static Route fade(page) => PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return page;
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(opacity: animation, child: child);
        },
      );

  static Route normal(page) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 0.1);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
}

Route routing(page, {ROUT_EFFECT type = ROUT_EFFECT.FADE}) {
  switch (type) {
    case ROUT_EFFECT.FADE:
      return RouteAnimation.fade(page);
      break;
    default:
      return RouteAnimation.normal(page);
  }
}
