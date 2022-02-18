part of '../address_card.dart';

class AddressRepository {
  static Future<String> addAddress([AddressModel address]) async {
    var codClient = SessionService.getCodClient;
    String code;
    await ApiService.fetch(
      Apis.addGeolocation(address.sendAddress(codClient)),
      onErrorMessage: "No hay contacto con servidor",
      verifyBasicToken: true,
      showSuccessDialog: false,
      onSuccess: (res) =>
          res.data is Map && res.data["entity"]["code"] is String
              ? code = res.data["entity"]["code"]
              : null,
    );
    return code;
  }

  static Future<AddressList> getUserAddresses(
      [String codClient, bool showSuccess = false]) async {
    if (codClient is String) {
      AddressList addreses;
      await ApiService.fetch(
        Apis.listGeolocation(AddressModel.getAddresses(codClient)),
        verifyBasicToken: showSuccess,
        showSuccessDialog: showSuccess,
        showLoading: false,
        onSuccess: (res) =>
            res.data is Map && res.data["entity"]["datalist"] is List
                ? addreses = AddressList.fromJson(res.data["entity"])
                : null,
      );
      return addreses;
    }
    return null;
  }

  static Future<bool> deleteAddress([AddressModel address]) async {
    var codClient = SessionService.getCodClient;
    return await ApiService.fetch(
      Apis.deleteGeolocatin(address.deleteAddress(codClient)),
      onErrorMessage: "No hay contacto con servidor",
      verifyBasicToken: true,
    );
  }

  static Future<bool> updateAddress([AddressModel address]) async {
    var codClient = SessionService.getCodClient;
    return await ApiService.fetch(
      Apis.updateGeolocation(address.updateAddress(codClient)),
      onErrorMessage: "No hay contacto con servidor",
      verifyBasicToken: true,
      showSuccessDialog: false,
    );
  }
}
