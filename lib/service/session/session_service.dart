import 'package:appclientes/cache/cache.dart';
import 'package:appclientes/packages/address_card/address_card.dart';
import 'package:appclientes/service/api/api_service.dart';
import 'package:appclientes/service/collector/collector_service.dart';
import 'package:appclientes/service/navigation/controller/navigation_controller.dart';
import 'package:appclientes/v_home/controller/index.dart';
import 'package:appclientes/v_card/controller/index.dart';
//import 'package:appclientes/v_order/controller/index.dart';

import '../services.dart';

class SessionService {
  ///[USER METHODS]
  ///
  /// [getUser]
  /// GETS THE USER MODEL
  static UserModel get getUser => SessionCache.getUser;

  /// [getCodClient]
  /// GETS USER CODE CLIENT
  static String get getCodClient => SessionCache.getUser?.code ?? '';

  /// [updateUser]
  /// METHOD TO UPDATE USER INFORMATION
  static Future<bool> updateUser(UserModel user) async {
    bool _setUser = await SessionCache.setUser(user);
    return _setUser;
  }

  /// [isFirstAccess]
  /// VALIDATE IF IT'S USER FIRST ACCESS
  static bool get isFirstAccess => SessionCache.getUser?.isFirstAccess ?? false;

  /// [logout]
  /// DELETES AND CLEANS ALL THE SERVICES
  static Future get logout async {
    ///[FILL WITH CLOSED METHODS]
    if (SessionCache.getUser is UserModel) {
      await AuthService.logout;
      await AppCache.deleteCache;
      CollectorService.cleanStates;
      RootApi.removeTokens;
      NavController.init;
    }
  }

  static Future get sessionPreferences async {
    final codClient = getCodClient;
    final addressList = await AddressRepository.getUserAddresses(codClient);
    final cardList = await CardRepository.getUserCards(codClient);
    //final orderList = await OrderRepository.getOrdersByClient(codClient);
    DialogService.showLoading;
    await Future.wait([
      AddressCache.setAddressList(addressList),
      CardCache.setCardList(cardList),
      //OrderCache.setOrderList(orderList),
      HomeEvents.initCategories,
      HomeEvents.initProducts,
    ]);
    DialogService.closeLoading;

    /// [FILL HERE WITH USER PREFERENCES]
  }

  static Future get partialPreferences async {
    DialogService.showLoading;
    await Future.wait([
      HomeEvents.initCategories,
    ]);
    DialogService.closeLoading;

    /// [FILL HERE WITH USER PARTIAL PREFERENCES]
  }
}
