part of 'auth_service.dart';

class AuthModel {
  static Map<String, dynamic> loginRequest(
          String id,
          String email,
          String password,
          String name,
          String lastName,
          AUTH_TYPE type,
          String pushtoken) =>
      {
        'grant_type': 'password',
        'idtypenetworksocial': id ?? 'app',
        'username': email,
        'password': password,
        'typenetworksocial': type?.index ?? 0,
        'nameuser': name,
        'lastnameuser': lastName,
        'pushtoken': pushtoken
      };
  static Map<String, dynamic> refreshTokenRequest(String token) => {
        'grant_type': 'refresh_token',
        'refresh_token': token,
      };
  static Map<String, dynamic> updateRequest(
    String code,
    String name,
    String lastname,
    String phone,
  ) =>
      {
        "entity": {
          "code": code,
          "name": name,
          "lastname": lastname,
          "phone": phone,
        }
      };

  static Map<String, dynamic> addPushToken(
    String code,
    String token,
  ) =>
      {
        "entity": {
          "code_user": code,
          "token": token,
        }
      };
}
