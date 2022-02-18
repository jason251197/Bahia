library reset_controller;

import 'package:appclientes/service/api/api_service.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:appclientes/shared/keys/global_keys.dart';

part 'reset_model.dart';
part 'reset_repository.dart';

class ResetPasswordController {
  static Future<bool> validateEmail() async {
    bool response;
    if (AppKeys.forgotFormKey.currentState.validate()) {
      response = await ResetRepostory.forgotPassword(
          FormController.emailForgotController.text);
      if (response)
        FormController.cleanController(FormController.emailForgotController);
    }
    return response;
  }
}
