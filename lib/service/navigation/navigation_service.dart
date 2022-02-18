import 'package:flutter/material.dart';
import 'animation/routing.dart';

class NavigationService {
  static NavigationService _instance;
  BuildContext appBarContext;

  NavigationService._();

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  BuildContext get getContext => navigatorKey.currentContext;

  Future navigateTo({@required Widget screen}) async =>
      await navigatorKey.currentState.push(routing(screen));

  Future navigateUntil({@required Widget screen}) async =>
      await navigatorKey.currentState
          .pushAndRemoveUntil(routing(screen), (Route<dynamic> route) => false);

  void pop() => navigatorKey.currentState.pop();

  void removeUntil(String route) => navigatorKey.currentState
      .pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);

  Future popUntil(String route) async =>
      navigatorKey.currentState.popUntil((ModalRoute.withName(route)));

  factory NavigationService() => _getInstance();

  static NavigationService _getInstance() {
    if (_instance == null) {
      _instance = NavigationService._();
    }
    return _instance;
  }
}
