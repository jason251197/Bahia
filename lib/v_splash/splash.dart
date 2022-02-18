import 'package:appclientes/service/notification/notification_service.dart';
import 'package:appclientes/v_splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'content/splashPortrait.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    NotificationService.getToken();
    SplashController.routeToScreen;
  }

  @override
  Widget build(BuildContext context) {
    return buildSplashPortrait;
  }
}
