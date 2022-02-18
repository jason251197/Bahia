import 'package:appclientes/service/services.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController {
  static void goToOnboarding() => NavController.goOnBoard;

  static void goToForgot() {
    FormController.clean();
    NavController.goToForgot();
  }

  static void fastAuth() => AuthService.fashAuth;

  static void goToRegister() async {
    FormController.clean();
    NavController.goToRegister();
  }

  static void authAccount(bool cartRedirect) {
    if (cartRedirect) {
      AuthService.loginAppAndRedirect;
    } else {
      AuthService.loginApp;
    }
  }

  static void later() async {
    bool _response = true;
    AuthService.tempAuth(_response, UserModel());
  }

  static Future<void> oAuth(AUTH_TYPE authType,bool cartRedirect) async {
    if (await AppConnectivity.check()) {
      switch (authType) {
        case AUTH_TYPE.FACEBOOK:
          await facebookLogin(cartRedirect);//await facebookLogin;
          break;
        case AUTH_TYPE.GOOGLE:
          await googleLogin(cartRedirect);//await googleLogin;
          break;
        case AUTH_TYPE.APPLE:
          await appleLogin(cartRedirect);//await appleLogin;
          break;
        default:
      }
    }
  }

  static Future<void> /*get*/ appleLogin(bool cartRedirect) async {
    try {
      final user = await OAuthService().appleSignIn();
      if (user is! UserModel)
        showErrorLogin;
      else
        if (cartRedirect){
          AuthService.redirectCartOnLogin(user);
        }else{
          AuthService.redirectOnLogin(user);
        }
    } on SignInWithAppleAuthorizationException catch (err) {
      switch (err.code) {
        case AuthorizationErrorCode.canceled:
          cancelledDialog;
          break;
        case AuthorizationErrorCode.failed:
          showErrorLogin;
          break;
        default:
      }
    }
  }

  static Future<void> /*get*/ facebookLogin(bool cartRedirect) async {
    DialogService.showLoading;
    final status = await OAuthService().loginWithFacebook(cartRedirect);
    DialogService.closeLoading;

    switch (status) {
      case FacebookLoginStatus.cancelledByUser:
        cancelledDialog;
        break;
      case FacebookLoginStatus.error:
        showErrorLogin;
        break;
      default:
    }
  }

  static get cancelledDialog =>
      DialogService.simpleDialog("Login cancelado por usuario");

  static Future<void> /*get*/ googleLogin(bool cartRedirect) async {
    final user = await OAuthService().loginWithGoogle();
    if (user is! UserModel)
      showErrorLogin;
    else
      if (cartRedirect){
        AuthService.redirectCartOnLogin(user);
      }else{
        AuthService.redirectOnLogin(user);
      }
  }

  static Future get showErrorLogin => DialogService.simpleDialog(
      "Hubo un error al procesar el login\n\nPor favor intente denuevo");
}
