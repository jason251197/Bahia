part of 'auth_service.dart';

class AuthExpire {
  /// MINUTES [max_time] 12 HOURs
  static const int max_time = 60 * 12;

  static String get getRefreshToken => SessionCache.getUser?.refreshToken ?? '';
  static String get getExpires => SessionCache.getUser?.expires ?? '';

  static void setExpireToken(String expToken) =>
      SessionCache.setToken(expToken);

  static Future<void> get refresh async {
    UserModel user = SessionCache.getUser;
    if (user is! UserModel || user.email.isEmpty) return;

    if (user.hasExpireDate) {
      Duration diff = DateTime.tryParse(getExpires).difference(DateTime.now());

      if (diff.inMinutes <= 0) {
        return await forceLogout;
      } else {
        if (diff.inDays <= AppParams.renovartokenAntesDeVencimiento) {//si vence en 60 dias
          return await refreshUser;
        }
      }
    } else {
      return await forceLogout;
    }
  }

  static Future<void> get refreshUser async {
    var user = await AuthRepository.refreshUser(getRefreshToken);
    Logger.log("REFRESH_TOKEN", [user?.accessToken ?? "NO TOKEN REFRESHED"]);
    AuthService._updateUser(user);
  }

  static Future<void> get forceLogout async {
    if (SessionCache.getUser is UserModel) {
      await DialogService.simpleDialog('Su sessión ha expirado');
      SessionService.logout;
    }
  }
}
