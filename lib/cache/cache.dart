library app_cache;

import 'package:appclientes/packages/address_card/address_card.dart';
import 'package:appclientes/service/session/model/user_model.dart';
import 'package:appclientes/shared/helpers/converter.dart';
import 'package:appclientes/service/logger/logger.dart';
import 'package:appclientes/v_card/controller/index.dart';
import 'package:appclientes/v_localization/controller/models/address_list.dart';
import 'package:appclientes/v_order/controller/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'address/address_cache.dart';
part 'session/session_cache.dart';
part 'card/card_cache.dart';
part 'order/order_cache.dart';

SharedPreferences cache;

class AppCache {
  static Future get deleteCache async {
    await AddressCache.deleteCache;
    await SessionCache.deleteCache;
    await CardCache.deleteCache;
    await OrderCache.deleteCache;
  }

  static bool get verifyAddress {
    return AddressCache.getCurrentAddress is AddressModel ||
        (AddressCache.getAddresList is AddressList &&
            AddressCache.getAddresList.isNotEmpty);
  }

  static bool get verifyToken => SessionCache?.getToken?.isNotEmpty ?? false;

  static String get getToken => SessionCache?.getToken;
}
