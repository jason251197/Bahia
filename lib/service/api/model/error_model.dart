class ErrorModel {
  ErrorModel({
    this.error,
    this.errorDescription,
  });

  String error;
  String errorDescription;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        error: json["error"],
        errorDescription: json["error_description"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "error_description": errorDescription,
      };
}
