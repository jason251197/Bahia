import 'package:appclientes/cache/cache.dart';
import 'package:appclientes/packages/address_card/address_card.dart';
import 'package:appclientes/service/auth/auth_service.dart';
import 'package:appclientes/service/collector/collector_service.dart';
import 'package:appclientes/service/logger/logger.dart';
import 'package:appclientes/service/sentry/sentry_service.dart';
import 'package:appclientes/service/services.dart';
import 'package:appclientes/service/version/version_service.dart';
import 'package:appclientes/v_card/card_web_view.dart';
import 'package:appclientes/v_dashboard/router/dashboard_router.dart';
import 'package:appclientes/v_localization/controller/localization_controller.dart';
import 'package:appclientes/v_localization/view/address_registered_view.dart';
import 'package:appclientes/v_localization/localization.dart';
import 'package:appclientes/v_login/login.dart';

import '../navigation_service.dart';
import '../constants/routes.dart';

class NavController {
  static log(value) => Logger.log("NavController", [value]);

  static void get goHome => NavigationService().removeUntil(ROUTES.DASHBOARD);

  static void get goLogin => NavigationService().removeUntil(ROUTES.LOGIN);

  static void get goLocalization =>
      NavigationService().removeUntil(ROUTES.MAPS);

  static void get rebirth => NavigationService().removeUntil(ROUTES.LOGIN);

  static void get goOnBoard => NavigationService().removeUntil(ROUTES.ONBOARD);

  static Future<void> get init async {
    final hasConnectivity = await AppConnectivity.check();

    if (hasConnectivity) {
      if (!await VersionService.initAppVersionCheck()) {
        final checkAccess = await _userHasAccess || await _userHasPartialAccess;
        if (!checkAccess) NavController.goLogin;
      }
    } else {
      final hasSession = AppCache.verifyToken;
      if (!hasSession) NavController.goLogin;
    }
  }

  static Future<void> get initForCart async {
    final hasConnectivity = await AppConnectivity.check();

    if (hasConnectivity) {
      final checkAccess = await _userOnPaymentAccess;
      if (!checkAccess) NavController.goLogin;
    } else {
      final hasSession = AppCache.verifyToken;
      if (!hasSession) NavController.goLogin;
    }
  }

  static bool doOpenLogin() {
    var hasToken = AppCache.verifyToken;
    if (!hasToken) NavController.goToLogin();
    return hasToken;
  }

  static void popToLogin() => NavigationService().popUntil(ROUTES.LOGIN);

  static void goToLogin() =>
      NavigationService().navigateTo(screen: LoginView(true));

  static void goToLoginOnPayment() =>
      NavigationService().navigateTo(screen: LoginView(true, true));

  static void goToHome() =>
      NavigationService().navigateUntil(screen: Dashboard());

  static void goToCart() =>
      NavigationService().navigateUntil(screen: Dashboard(ROUTE_PAGE.CART));
  
  static void goToOrder() =>
      NavigationService().navigateUntil(screen: Dashboard(ROUTE_PAGE.ORDER));

  static void goToProfile() =>
      NavigationService().navigateUntil(screen: Dashboard(ROUTE_PAGE.PROFILE));

  static void goToForgot() =>
      NavigationService().navigateTo(screen: ResetPasswordView());

  static void goToOnboard() =>
      NavigationService().navigateTo(screen: OnBoardingView());

  static void goToRegister() =>
      NavigationService().navigateTo(screen: RegisterView());

  static void goToCardWebView() =>
      NavigationService().navigateTo(screen: AddCardWebView());

  static void goToMaps() => NavigationService().navigateTo(
      screen: LocalizationView(canPop: true, blockRedirectAddress: true));

  static void goToRegisterAddress() =>
      NavigationService().navigateTo(screen: AddressRegisteredView());

  static void showOnboard() =>
      NavigationService().navigateTo(screen: OnBoardingView(true));

  static Future<bool> get _userHasAccess async {
    await SessionService.sessionPreferences;

    final hasAccess = AppCache.verifyToken && AppCache.verifyAddress;

    log("\n*** HAS ACCESS $hasAccess\n");

    if (hasAccess) {
      await accessConfirmed;
      await AuthExpire.refresh;
      NavController.goHome;
    }
    return hasAccess;
  }

  static Future<bool> get _userOnPaymentAccess async {
    final hasAccess = AppCache.verifyToken && AppCache.verifyAddress;

    log("\n*** HAS ACCESS $hasAccess\n");

    if (hasAccess) {
      await updateAddress();
      await SessionService.sessionPreferences;
      await accessConfirmed;
      await AuthExpire.refresh;
      NavController.goToCart();
    }
    return hasAccess;
  }

  static Future<void> updateAddress() async {
    final address = AddressCache.getCurrentAddress;
    final addressCode = await AddressRepository.addAddress(address);
    address.code = addressCode ?? '';
    if (addressCode is! String) {
      Logger.log('update-address-on-register', [addressCode, address]);
    }
    await LocalizationController.selectAddress(address);
  }

  static Future<bool> get _userHasPartialAccess async {
    final hasPartialAddress = AppCache.verifyToken && !AppCache.verifyAddress;
    log("IS_FIRST_ACCESS ${SessionService.isFirstAccess}");
    log("\n*** HAS PARTIAL ACCESS $hasPartialAddress\n");

    if (hasPartialAddress) {
      await accessConfirmed;
      if (SessionService.isFirstAccess)
        NavController.goOnBoard;
      else
        NavController.goLocalization;
    }
    return hasPartialAddress;
  }

  static get reloadHome async {
    await SessionService.sessionPreferences;
    CollectorService.cleanCart;
    goHome;
  }

  static get accessConfirmed async {
    SentryService().initPrefs(SessionCache.getUser);
  }
}
