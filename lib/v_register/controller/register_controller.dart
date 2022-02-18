import 'package:appclientes/service/services.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:appclientes/shared/keys/global_keys.dart';

import 'register_repository.dart';

class RegisterController {
  static Future<bool> registerAccount() async {
    if (AppKeys.registerFormKey.currentState.validate()) {
      if (FormController.password3Controller.text ==
          FormController.password2Controller.text) {
        return await RegisterRepository.register();
      } else
        DialogService.simpleDialog('Las Contraseñas no coinciden');
    }
    return false;
  }

  static Future<void> oAuthRegister(
      int type, String name, String email, String password) async {
    await RegisterRepository.register(type, email, name, password);
  }
}
