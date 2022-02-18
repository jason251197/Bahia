import 'package:appclientes/service/api/api_service.dart';
import 'package:appclientes/service/navigation/controller/navigation_controller.dart';
import 'package:appclientes/service/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import '../view/start_up.dart';

class OnBoardingController {
  static verifyToNavigation(PageController pageController, bool canPop) {
    if (pageController.page == 3) {
      if (canPop)
        NavigationService().pop();
      else
        goStartup();
    } else
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
  }

  static redirectToMaps() async {
    if (await AppConnectivity.check()) NavController.goToMaps();
  }

  static void goStartup() =>
      NavigationService().navigateTo(screen: StartUpView());
}
