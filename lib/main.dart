import 'package:appclientes/service/navigation/navigation_service.dart';
import 'package:appclientes/shared/theme/theme.dart';
import 'package:appclientes/v_splash/splash.dart';
import 'package:flutter/material.dart';

import 'service/boot/boot.dart';
import 'service/cycle/app_cycle_service.dart';
import 'service/localization/localization_service.dart';
import 'service/navigation/constants/routes.dart';
import 'v_dashboard/router/dashboard_router.dart';
import 'v_localization/localization.dart';
import 'v_login/login.dart';
import 'v_splash/splash.dart';

void main() async {
  await BootService.initializeServices;
  runApp(PlanetOliverApp());
}

class PlanetOliverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '',
        theme: ThemeApp.getTheme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: LocalizationService.localizations,
        supportedLocales: LocalizationService.locales,
        builder: (_, __) => AppCycle(__),
        navigatorKey: NavigationService().navigatorKey,
        initialRoute: ROUTES.SPLASH,
        routes: {
          ROUTES.SPLASH: (_) => SplashView(),
          ROUTES.LOGIN: (_) => LoginView(),
          ROUTES.ONBOARD: (_) => OnBoardingView(),
          ROUTES.MAPS: (_) => LocalizationView(),
          ROUTES.DASHBOARD: (_) => Dashboard(),
        });
  }
}
