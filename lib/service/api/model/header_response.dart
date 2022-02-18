class HeaderResponseModel {
  HeaderResponseModel({
    this.code,
    this.description,
    this.status,
  });
  String code;
  String description;
  bool status;

  factory HeaderResponseModel.fromJson(Map<String, dynamic> json) => HeaderResponseModel(
        code: json["code"],
        description: json["description"],
        status: json["status"],
      );

  Map toJson() => {
        "code": code ?? '',
        "description": description ?? 0,
        "status": status ?? false,
      };


}
