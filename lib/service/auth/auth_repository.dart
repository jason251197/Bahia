part of 'auth_service.dart';

class AuthRepository {
  static Future<UserModel> login(
      [String userId,
      String email,
      String token,
      String name,
      String lastName,
      AUTH_TYPE type]) async {
    String pushtoken = SessionCache.getPushToken;
    if (pushtoken == null) {
      pushtoken = await NotificationService.getToken();
    }
    var user;
    String msjError =
        "Usuario y/o contraseña no coinciden\no usuario no existe,\n\npor favor verifique sus credenciales";
    if (type == AUTH_TYPE.OLIVER &&
        (FormController.passwordController.text.isEmpty ||
            FormController.passwordController.text.length < 8)) {
      await DialogService.simpleDialog(msjError);
    } else {
      await ApiService.fetch(
        Apis.createToken(AuthModel.loginRequest(
            userId ?? 'app',
            email ?? FormController.emailController.text,
            token ?? FormController.passwordController.text,
            name ?? 'x',
            lastName ?? 'x',
            type,
            pushtoken)),
        onErrorMessage: msjError,
        onSuccess: (res) => user = UserModel.fromJson(res.data),
      );
    }
    return user;
  }

  static Future<UserModel> refreshUser(String token) async {
    var user;
    await ApiService.fetch(
      Apis.createToken(AuthModel.refreshTokenRequest(token)),
      onSuccess: (res) => user = UserModel.fromJson(res.data),
      showSuccessDialog: false,
      refresh: false,
    );
    return user;
  }

  static Future<UserModel> addPushToken() async {
    String pushtoken = SessionCache.getPushToken;
    if (pushtoken == null) {
      pushtoken = await NotificationService.getToken();
    }
    var code = SessionCache.getUser.code;
    var user;
    await ApiService.fetch(
      Apis.addPushtoken(AuthModel.addPushToken(code, pushtoken)),
      showSuccessDialog: false,
      refresh: false,
    );
    return user;
  }

  static Future<bool> updateUser(String code) async {
    return await ApiService.fetch(
      Apis.updateUser(AuthModel.updateRequest(
        code,
        FormController.nameController.text,
        FormController.lastNController.text,
        FormController.phoneController.text,
      )),
      verifyBasicToken: true,
      showSuccessDialog: false,
    );
  }
}
