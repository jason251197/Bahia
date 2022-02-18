library auth_service;

import 'package:appclientes/cache/cache.dart';
import 'package:appclientes/service/logger/logger.dart';
import 'package:appclientes/service/notification/notification_service.dart';

import 'package:appclientes/shared/constants/urls.dart';
import 'package:appclientes/shared/helpers/converter.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../navigation/controller/navigation_controller.dart';
import '../services.dart';
import '../api/api_service.dart';
import 'package:appclientes/shared/constants/params.dart';

part 'oauth_service.dart';
part 'auth_repository.dart';
part 'auth_model.dart';
part 'auth_expire.dart';

enum AUTH_TYPE {
  OLIVER,
  APPLE,
  FACEBOOK,
  GOOGLE,
}

class AuthService {
  static const String _fakeToken = "2873984u09j309d2md9n9130dn";

  /// [TOKEN - SECTION]
  static Future<bool> _setToken(String token) async =>
      await SessionCache.setToken(token ?? _fakeToken);

  static Future<bool> _setUser(UserModel user) async =>
      await SessionCache.setUser(user);

  /// [AUTH - SECTION]
  static Future doAuth(bool response, UserModel user) async {
    if (response) {
      FormController.clean();

      if (await _updateUser(user))
        NavController.init;
      else
        NavController.goLogin;
    }
  }

  static Future doAuthForCart(bool response, UserModel user) async {
    if (response) {
      FormController.clean();

      if (await _updateUser(user))
        NavController.initForCart;
      else
        NavController.goLogin;
    }
  }

  static Future<bool> _updateUser(UserModel user) async {
    if (user is UserModel && user.accessToken is String) {
      RootApi.setToken(user.accessToken);
      return (await AuthService._setToken(user?.accessToken) &&
          await AuthService._setUser(user));
    }
    return false;
  }

  static Future tempAuth(bool response, UserModel user) async {
    if (response) {
      FormController.clean();
      if (await AuthService._setUser(user) && !AppCache.verifyAddress)
        NavController.goToOnboard();
      else {
        await SessionService.sessionPreferences;

        NavController.goToHome();
      }
    }
  }

  /// [AUTH - SECTION]
  static void get loginApp async {
    UserModel user = await AuthRepository.login();
    redirectOnLogin(user);
  }

  static void get loginAppAndRedirect async {
    UserModel user = await AuthRepository.login();
    redirectCartOnLogin(user);
  }

  static void get fashAuth async {
    FormController.emailController.text = 'Jcalderon.sys@gmail.com';
    FormController.passwordController.text = '12345678';

    UserModel user = await AuthRepository.login(
      'Jcalderon.sys@gmail.com',
      '12345678',
    );
    redirectOnLogin(user);
  }

  static redirectOnLogin(UserModel user) =>
      AuthService.doAuth(user is UserModel, user);

  static redirectCartOnLogin(UserModel user) =>
      AuthService.doAuthForCart(user is UserModel, user);

  static Future<void> get logout async {
    if (await OAuthService.googleSignIn.isSignedIn())
      OAuthService.googleSignIn.disconnect();
    if (await OAuthService.facebookSignIn.isLoggedIn)
      OAuthService.facebookSignIn.logOut();
  }
}
