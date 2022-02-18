import 'package:sentry/sentry.dart';

class UserModel {
  String name;
  String lastname;
  String email;
  String phone;
  String accessToken;
  String tokenType;
  int expiresIn;
  String refreshToken;
  String code;
  String issued;
  String publickey;
  String expires;
  String firstaccess;

  UserModel(
      {this.name = "",
      this.lastname = "",
      this.email = "",
      this.phone = "",
      this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.refreshToken,
      this.code,
      this.issued,
      this.publickey,
      this.expires,
      this.firstaccess});

  final _seen = "0";
  get hasExpireDate => expires is String;

  bool get isFirstAccess => firstaccess is String && firstaccess == _seen;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"] ?? "",
        lastname: json["lastname"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        refreshToken: json["refresh_token"],
        code: json["code"],
        publickey: json["publickey"],
        issued: json[".issued"],
        expires: json["expires_in"] is int
            ? DateTime.now()
                .add(Duration(seconds: json["expires_in"]))
                .toString()
            : null,
        firstaccess: json["firstaccess"],
      );

  Map toJson() => {
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "refresh_token": refreshToken,
        "code": code,
        "publickey": publickey,
        ".issued": issued,
        ".expires": expires,
        "firstaccess": firstaccess,
      };

  Map<String, dynamic> fakeUser = {
    "name": "jorge",
    "lastname": "antonio",
    "email": "jorge.antonio@gmail.com",
    "phone": "988238123",
  };

  Map<String, dynamic> emptyUser = {
    "name": "",
    "lastname": "",
    "email": "",
    "phone": "",
  };

  ///[SENTRY USER PORPOSE]
  Map<String, dynamic> get sentryExtras => {
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "refresh_token": refreshToken,
        "code": code,
        ".issued": issued,
        ".expires": expires,
        "firstaccess": firstaccess,
      };

  User get toSentryUserModel => new User(
        username: "$name, $lastname",
        email: email,
        id: 'no id',
        extras: this.sentryExtras,
      );
}
