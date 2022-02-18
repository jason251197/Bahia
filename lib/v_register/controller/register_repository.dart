import 'package:appclientes/service/api/api_service.dart';
import 'package:appclientes/service/logger/logger.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:appclientes/v_register/controller/register_model.dart';

class RegisterRepository {
  static const _idty = "register_repository";
  static void log(value) =>  Logger.log(_idty,[value]);

  static Future<bool> register([
    int type = 0,
    String name = '',
    String email = '',
    String password = '',
  ]) async {
    return await ApiService.fetch(
      Apis.register(RegisterModel.toMap(
        email.isEmpty ? FormController.emailController.text : email,
        password.isEmpty ? FormController.password2Controller.text : password,
        name.isEmpty ? FormController.nameController.text : name,
        FormController.lastNController.text,
        FormController.phoneController.text,
        type,
      )),
      onSuccess: (res) => log(res),
    );
  }
}
