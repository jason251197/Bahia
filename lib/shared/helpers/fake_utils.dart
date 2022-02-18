import 'package:appclientes/service/dialog/dialog_service.dart';

class Fake {
  static Future<void> get loading async {
    DialogService.showLoading;
    await Future.delayed(Duration(milliseconds: 1200));
    DialogService.closeLoading;
  }
}
