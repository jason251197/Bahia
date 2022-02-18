part of '../address_card.dart';

class AddressModel {
  String code;
  String name;
  String address;
  String references;
  num latitude;
  num longitude;

  AddressModel({
    this.code,
    this.name,
    this.address,
    this.references,
    this.latitude,
    this.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      code: json["code"] ?? "",
      address: json["address"] ?? '',
      name: json["name"] ?? '',
      references: json["references"] ?? "",
      latitude: json["latitude"] is num ? json["latitude"] : 0.0,
      longitude: json["longitude"] is num ? json["longitude"] : 0.0,
    );
  }

  Map toJson() => {
        "code": code ?? '',
        "name": name ?? '',
        "address": address ?? '',
        "latitude": latitude ?? '',
        "longitude": longitude ?? '',
        "references": references ?? "",
      };

  /// ------- { END OF BASE MODEL} ---------

  /// [REQUEST]
  ///
  /// [sendAddress]
  /// This is used  to [add] new address
  Map<String, dynamic> sendAddress(codClient) => {
        "entity": {
          "name": name ?? '',
          "address": address ?? '',
          "latitude": latitude ?? 0.0,
          "longitude": longitude ?? 0.0,
          "references": references ?? "",
          "codeclient": codClient
        }
      };

  /// [updateAddress]
  /// This is used  to [update] new address
  Map<String, dynamic> updateAddress(codClient) => {
        "entity": {
          "code": code ?? '',
          "name": name ?? '',
          "address": address ?? '',
          "latitude": latitude ?? 0.0,
          "longitude": longitude ?? 0.0,
          "references": references ?? "",
          "codeclient": codClient
        }
      };

  /// [getAddresses]
  /// This is used  to [get] all user addresses
  static Map<String, dynamic> getAddresses(codClient) => {
        "entity": {"codeclient": codClient}
      };

  /// [deleteAddress]
  /// This is used  to [delete] an address
  Map<String, dynamic> deleteAddress(codClient) => {
        "entity": {"code": code, "codeclient": codClient}
      };

  /// [shortAddress]
  /// this is used to display the current address
  String get shortAddress {
    try {
      final addessSplitted = address.split(',');
      String _direction = addessSplitted[0] + ',' + addessSplitted[1];
      if (_direction is String && references is String)
        return "$_direction, $references";
      if (address is String) return "$address";
    } catch (err) {
      // onError();
    }
    return null;
  }

  bool get hasCoordenates => latitude is num && longitude is num;

  void onError() async {
    await AddressCache.deleteCache;
  }
}
