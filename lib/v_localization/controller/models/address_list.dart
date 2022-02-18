import 'package:appclientes/packages/address_card/address_card.dart';

class AddressList {
  List<AddressModel> addresses = <AddressModel>[];
  AddressList({this.addresses});

  Map toJson() => {"datalist": addresses};

  factory AddressList.fromJson(Map<String, dynamic> json) => AddressList(
        addresses: List<AddressModel>.from(
            json["datalist"].map((a) => AddressModel.fromJson(a))),
      );

  List<AddressModel> get getAddresses => addresses ?? [];

  get isNotEmpty => addresses is List<AddressModel> && addresses.isNotEmpty;
}
