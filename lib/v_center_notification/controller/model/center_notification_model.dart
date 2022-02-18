class CenterNotificationModel {
  CenterNotificationModel({
    this.stateNotificationFavourite,
  });

  bool stateNotificationFavourite;

  factory CenterNotificationModel.fromJson(Map<String, dynamic> json) =>
      CenterNotificationModel(
        stateNotificationFavourite:
            json["statenotificationsfavourite"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "statenotificationsfavourite": stateNotificationFavourite,
      };

  static Map<String, dynamic> getStateClient(codClient) => {
        "entity": {"code": codClient}
      };

  static Map<String, dynamic> saveStateClient(codClient, state) => {
        "entity": {"codigo": codClient, "state": state}
      };
}
