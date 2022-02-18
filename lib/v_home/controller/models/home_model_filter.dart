part of '../index.dart';

class FilterModel {
  final _productFiltered = "P";
  final _localFiltered = "L";

  FilterModel({
    this.geolocationCode,
    this.currentLocation,
    this.latitude,
    this.longitude,
    this.searchInput,
    this.catCode,
    this.isProductLocal,
    this.orderType,
    this.codeclient,
    this.pageNumber,
  });

  String geolocationCode;
  String currentLocation;
  num latitude;
  num longitude;
  String searchInput;
  String catCode;
  String isProductLocal;
  String orderType;
  String codeclient;
  int pageNumber;

  get isProductFilter => variant == _productFiltered;
  get isLocalFilter => variant == _localFiltered;

  get variant => isProductLocal ?? 'L';
  get order => orderType ?? '%';
  String get categoryCode => catCode ?? '%';

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        geolocationCode: json["geolocation_code"],
        currentLocation: json["current_location"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        searchInput: json["search_input"],
        catCode: json["cat_code"],
        isProductLocal: json["is_product_local"],
        orderType: json["order_type"],
        codeclient: json["codeclient"],
        pageNumber: json["page_number"],
      );

  Map<String, dynamic> get toJson => {
        "entity": {
          "geolocation_code": geolocationCode,
          // "current_location": currentLocation,
          "latitude": latitude ?? 0,
          "longitude": longitude ?? 0,
          "search_input": searchInput ?? '',
          "cat_code": categoryCode ?? '',
          "is_product_local": variant,
          "order_type": order,
          "codeclient": codeclient ?? '',
          "page_number": pageNumber ?? 1,
        }
      };
}
