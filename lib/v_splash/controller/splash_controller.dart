import 'package:appclientes/service/navigation/controller/navigation_controller.dart';

class SplashController {
  static Future<void> get routeToScreen async {
    await NavController.init;
  }
}
