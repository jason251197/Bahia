class RegisterModel {
  static Map<String, dynamic> toMap(
    String email,
    String password,
    String name,
    String lastname,
    String phone,
    int type,
  ) =>
      {
        "entity": {
          "name": name,
          "email": email,
          "lastname": lastname,
          "password": password,
          "phone": phone,
          "typenetworksocial": type,
        }
      };
}
