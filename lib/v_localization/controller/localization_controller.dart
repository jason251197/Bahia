import 'package:appclientes/cache/cache.dart';
import 'package:appclientes/packages/address_card/address_card.dart';
import 'package:appclientes/service/dialog/dialog_service.dart';
import 'package:appclientes/service/navigation/controller/navigation_controller.dart';
import 'package:appclientes/service/navigation/navigation_service.dart';
import 'package:appclientes/shared/components/app_bar/controller/app_bar_state.dart';
import 'package:appclientes/shared/helpers/fake_utils.dart';
import 'package:appclientes/v_localization/controller/models/address_list.dart';
import 'package:appclientes/v_localization/localization.dart';

class LocalizationController {
  static void saveAddress(AddressModel address, {bool doPop = false}) async {
    final addressList = loadAddresses?.getAddresses ?? [];

    if (addressList.isEmpty) await selectAddress(address);
    
    var myAddress = addressList.firstWhere((element) =>
                    (element.address==address.address),
                    orElse: () {return null;}
                    );
    if (myAddress == null) {
      if (await AddressCache.addAddressList(address))
          await Fake.loading
                .then((value) => doPop ? goBack() : NavController.reloadHome);
    }else{
      await DialogService.notAddAddressDialog;
    }  
  }

  static void goBack() => NavigationService().pop();

  static AddressList get loadAddresses => AddressCache.getAddresList;

  static Future<bool> deleteAddres(AddressModel addressModel) async {
    if (await DialogService.deleteAddress) {
      if (await AddressRepository.deleteAddress(addressModel))
        return await AddressCache.deleteAddress(addressModel);
    }
    return false;
  }

  static Future<bool> updateCacheAddress(AddressModel addressModel) async =>
      await AddressCache.updateAddress(addressModel);

  static Future<void> goToAddAddress() async => await NavigationService()
      .navigateTo(screen: LocalizationView(addAddress: true));

  static Future<bool> openAddress(AddressModel address) async =>
      await NavigationService()
          .navigateTo(screen: LocalizationView(address: address)) ??
      false;

  static void updateSelectedAddressAndLoad(AddressModel current) async {
    await selectAddress(current);
    NavController.reloadHome;
  }

  /// updates [selectAddress] with cache & state
  /// [AddressCache] storage
  /// [AddressState] temp cache
  static Future selectAddress(AddressModel address) async {
    AddressState().update(address);
    await AddressCache.setSelectedAddress(address);
  }
}
