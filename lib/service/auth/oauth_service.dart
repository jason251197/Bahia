part of 'auth_service.dart';

class OAuthService {
  static final facebookSignIn = new FacebookLogin()
    ..loginBehavior = FacebookLoginBehavior.webViewOnly;

  static final googleSignIn = GoogleSignIn();

  static const _email = "email";

  Future<UserModel> loginWithGoogle() async {
    final profile = await googleSignIn.signIn();
    // UserModel _user =
    final auth = await profile.authentication;
    return await OAuthService.googleToUser(profile, auth.accessToken);
  }

  Future<FacebookLoginStatus> loginWithFacebook(bool cartRedirect) async {
    final FacebookLoginResult result = await facebookSignIn.logIn([_email]);
    if (result.status == FacebookLoginStatus.loggedIn) {
      final FacebookAccessToken accessToken = result.accessToken;
      final user = await setUserFacebook(accessToken.token);
      if (cartRedirect) {
        AuthService.redirectCartOnLogin(user);
      } else {
        AuthService.redirectOnLogin(user);
      }
    }

    return result.status;
  }

  Future<UserModel> appleSignIn() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    //print('$credential');
    await SentryService().sendInfoLog({
      "identityToken": credential?.identityToken,
      "userIdentifier": credential?.userIdentifier,
      "state": credential?.state,
      "authorizationCode": credential?.authorizationCode
    });

    return await OAuthService.appleToUser(credential);
  }

  Future<UserModel> setUserFacebook(String token) async {
    final graphResponse = await Dio().get('${AppURLs.facebookURL}$token');
    final profile = AppConverter.toObject(graphResponse.data);
    return await OAuthService.facebookToUser(profile, token);
  }

  /// <------------------------    [CONVERTERS]   -----------------------------_>

  static Future<UserModel> googleToUser(
          GoogleSignInAccount user, String token) async =>
      await createAccount(AUTH_TYPE.GOOGLE, user.id, user.email,
          user.displayName, user.displayName, token);

  static Future<UserModel> facebookToUser(Map user, String token) async =>
      await createAccount(AUTH_TYPE.FACEBOOK, token, user["email"], user["id"],
          user["first_name"] ?? 'x', user["last_name"] ?? 'x');

  static Future<UserModel> appleToUser(
          AuthorizationCredentialAppleID user) async =>
      await createAccount(
          AUTH_TYPE.APPLE,
          user.userIdentifier,
          user.email ?? 'x',
          user.givenName ?? 'x',
          user.familyName ?? 'x',
          user.userIdentifier);

  static Future<UserModel> createAccount(AUTH_TYPE type, id, String email,
      String name, String lastName, String token) async {
    return await AuthRepository.login(
        id.toString(), email, token, name, lastName, type);
  }
}
