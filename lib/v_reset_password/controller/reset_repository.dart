part of 'reset_controller.dart';

class ResetRepostory {
  static Future<bool> forgotPassword(String email) async {
    bool isSuccess;
    try {
      await ApiService.fetch(
        Apis.forgot(ResetModel.forgotPassword(email)),
        onErrorMessage: 'Error de conexión con servidor',
        onSuccess: (_) => isSuccess =
            _.data is Map ? _.data['result']['status'] ?? false : false,
      );
    } catch (_) {}
    return isSuccess ?? false;
  }
}
