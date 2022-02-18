part of 'reset_controller.dart';

class ResetModel {
  static Map<String, dynamic> forgotPassword(String email) => {
        "entity": {"email": email}
      };
}
