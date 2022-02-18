import 'package:appclientes/cache/cache.dart';
import 'package:appclientes/service/launcher/launcher.dart';
import 'package:appclientes/service/notification/notification_service.dart';
import 'package:appclientes/service/services.dart';
import 'package:appclientes/shared/constants/urls.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:appclientes/shared/keys/global_keys.dart';
import 'package:appclientes/v_profile/data/profile_data.dart';

class ProfileController {
  // static void logout() => SessionService.logout;
  static void logout() async {
    if (await DialogService.logout) {
      NotificationService.removeToken();
      SessionService.logout;
    }
  }

  static Future<bool> get saveProfile async {
    if (AppKeys.editFormKey.currentState.validate()) {
      UserModel _user = SessionService.getUser ?? UserModel();

      _user.name = FormController.nameController.text;
      _user.lastname = FormController.lastNController.text;
      _user.phone = FormController.phoneController.text;

      bool response = await AuthRepository.updateUser(_user.code);
      if (response && await SessionService.updateUser(_user)) return true;
    }
    return false;
  }

  static UserModel get loadProfile => SessionService.getUser;

  static void get loadToEditProfile {
    UserModel _user = loadProfile;
    FormController.emailController.text = _user.email;
    FormController.nameController.text = _user.name;
    FormController.lastNController.text = _user.lastname;
    FormController.phoneController.text = _user.phone;
  }

  static Future<bool> get hasToken async {
    var hasToken = AppCache.verifyToken;
    if (!hasToken) NavController.goToLogin();

    return hasToken;
  }

  /// DIALOGS
  static Future<void> cancelAccount() async => await DialogService.closeAccount;
  static Future<void> contactUs() async => await DialogService.contactUs;
  static Future<void> cancelOrder() async => await DialogService.cancelOrder;

  ///REDIRECTIONS
  static void showOnBoard() => NavController.showOnboard();
  static void openTerms() => LauncherService.launchURL(AppURLs.terms2);

  static String getInputValues(UserModel user, Map input) {
    switch (input['key']) {
      case PROFILE_INPUT.NAME:
        return user.name;
        break;
      case PROFILE_INPUT.LASTNAME:
        return user.lastname;
        break;
      case PROFILE_INPUT.EMAIL:
        return user.email;
        break;
      case PROFILE_INPUT.PHONE:
        return user.phone;
        break;
      default:
        return '';
    }
  }
}
