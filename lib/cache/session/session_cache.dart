part of '../cache.dart';

class SessionCache {
  static const String _AUTH_TOKEN = "token";
  static const String _PUSH_TOKEN = "push_token";
  static const String _USER_INFO = "user_info";

  static const List<String> _KEY_LIST = [_AUTH_TOKEN, _USER_INFO, _PUSH_TOKEN];

  static String get getToken => cache.getString(_AUTH_TOKEN);

  static Future<bool> setToken(String token) async =>
      await cache.setString(_AUTH_TOKEN, token);

  static String get getPushToken => cache.getString(_PUSH_TOKEN);

  static Future<bool> setPushToken(String token) async =>
      await cache.setString(_PUSH_TOKEN, token);

  static UserModel get getUser {
    String _user = cache.getString(_USER_INFO);
    if (_user is String)
      return UserModel.fromJson(AppConverter.toObject(_user));
    return null;
  }

  static Future<bool> setUser(UserModel user) async {
    String userData = AppConverter.toJson(user.toJson());

    return await cache.setString(_USER_INFO, userData);
  }

  ///Shared Preference Method to delete data from SharedPreferences
  static Future get deleteCache async {
    _KEY_LIST.forEach((key) => cache.remove(key));
  }
}
