part of '../cache.dart';

class OrderCache {
  static const String _ORDER_LIST = "order_list";
  static const String _ORDER_SELECTED = "order_current";

  static const List<String> _KEY_LIST = [
    _ORDER_LIST,
    _ORDER_SELECTED,
  ];



  static OrderList get getOrderList {
    try {
      String _list = cache.getString(_ORDER_LIST);
      if (_list is String) {
        Map data = AppConverter.toObject(_list);
        return OrderList.fromJson(data);
      }
    } catch (err) {
      Logger.err("getCardList", err);
    }
    return null;
  }

  static Future<bool> setOrderList(OrderList orderList) async {
    try {
      String _json = AppConverter.toJson(orderList);
      return await cache.setString(_ORDER_LIST, _json);
    } catch (err) {
      Logger.err("setOrderList", err);
    }
    return false;
  }
  ///Shared Preference Method to delete data from SharedPreferences
  static Future get deleteCache async {
    _KEY_LIST.forEach((key) => cache.remove(key));
  }
}
