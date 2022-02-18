export 'package:appclientes/v_on_boarding/on_boarding.dart';
export 'package:appclientes/v_register/register.dart';
export 'package:appclientes/v_reset_password/reset_password.dart';

class ROUTES {
  static const String SPLASH = "/splash";
  static const String LOGIN = "/login";
  static const String MAPS = "/localitation";
  static const String DASHBOARD = "/dashboard";
  static const String ONBOARD = "/onBoarding";
}

enum ROUTE_PAGE { HOME, CART, ORDER, PROFILE }

enum ROUTE_HOME { SEARCH, RESTAURANT, FOOD }

enum ROUTE_SEARCH { RESTAURANT, FOOD }
