part of '../index.dart';

class CategoryModel {
  CategoryModel({
    this.catCode,
    this.catName,
  });

  String catCode;
  String catName;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        catCode: json["cat_code"] ?? '',
        catName: json["cat_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "cat_code": catCode,
        "cat_name": catName,
      };

  /// [getAddresses]
  /// This is used  to [get] all categories
  static Map<String, dynamic> getCategories(codClient) => {
        "entity": {"codeclient": codClient}
      };
}
