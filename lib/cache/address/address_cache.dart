part of '../cache.dart';

class AddressCache {
  static const String _ADDRESS_LIST = "address_list";
  static const String _ADDRESS_SELECTED = "address_current";

  static const List<String> _KEY_LIST = [
    _ADDRESS_LIST,
    _ADDRESS_SELECTED,
  ];

  static AddressModel get getCurrentAddress {
    try {
      String _address = cache.getString(_ADDRESS_SELECTED);
      if (_address is String) {
        Map data = AppConverter.toObject(_address);
        return AddressModel.fromJson(data);
      }
    } catch (err, stack) {
      Logger.err("getCurrentAddress", err, stack);
    }
    return null;
  }

  static Future<bool> setSelectedAddress(AddressModel address) async {
    if (address is AddressModel) {
      try {
        String _address = AppConverter.toJson(address);
        await cache.setString(_ADDRESS_SELECTED, _address);
      } catch (err, stack) {
        Logger.err("setSelectedAddress", err, stack);
      }
    }
    return false;
  }

  static Future<bool> setAddressList(AddressList addressList) async {
    if (addressList is AddressList) {
      try {
        String _json = AppConverter.toJson(addressList);
        if (getCurrentAddress == null) {
          setSelectedAddress(addressList.getAddresses[0]);
        }else{
          if (addressList.addresses.length>0) {
            bool exist =(addressList.addresses.any((e) => e.code == getCurrentAddress.code));
            if (!exist){
              setSelectedAddress(addressList.getAddresses[0]);
            }
          }
        }
        return await cache.setString(_ADDRESS_LIST, _json);
      } catch (err) {
        Logger.err("setAddressList", err);
      }
    }
    return false;
  }

  static Future<bool> addAddressList(AddressModel address) async {
    try {
      AddressList addressList = AddressCache?.getAddresList ?? AddressList();
      addressList.addresses = [address, ...addressList.getAddresses];
      return await setAddressList(addressList);
    } catch (err, stack) {
      Logger.err("addAddressList", err, stack);
    }
    return false;
  }

  static Future<bool> deleteAddress(AddressModel address) async {
    try {
      doCleanAddress(address);
      AddressList addressList = AddressCache?.getAddresList ?? AddressList();
      addressList.addresses.removeWhere((e) => e.code == address.code);
      return await setAddressList(addressList);
    } catch (err, stack) {
      Logger.err("deleteAddress", err, stack);
    }
    return false;
  }

  static Future<bool> updateAddress(AddressModel address) async {
    if (address is AddressModel) {
      try {
        AddressList addressList = AddressCache?.getAddresList ?? AddressList();
        addressList.addresses.removeWhere((e) => e.code == address.code);
        addressList.addresses.add(address);
        return await setAddressList(addressList);
      } catch (err, stack) {
        Logger.err("updateAddress", err, stack);
      }
    }
    return false;
  }

  static void doCleanAddress(AddressModel address) {
    var currentAddress = AddressCache?.getCurrentAddress;
    if (currentAddress is AddressModel &&
        currentAddress.shortAddress == address.shortAddress &&
        address is AddressModel)
      AddressCache.setSelectedAddress(AddressModel());
  }

  static AddressList get getAddresList {
    try {
      String _list = cache.getString(_ADDRESS_LIST);
      if (_list is String) {
        Map data = AppConverter.toObject(_list);
        return AddressList.fromJson(data);
      }
    } catch (err) {
      Logger.err("getAddresList", err);
    }
    return null;
  }

  ///Shared Preference Method to delete data from SharedPreferences
  static Future get deleteCache async {
    _KEY_LIST.forEach((key) => cache.remove(key));
  }
}
