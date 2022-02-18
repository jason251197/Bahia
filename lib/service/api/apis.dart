part of './api_service.dart';

class Apis {
  static Future<Response> createToken(Map<String, dynamic> body) async =>
      await RootApi.Encoded('/gettoken', body: body);

  static Future<Response> register(Map<String, dynamic> body) async =>
      await RootApi.Post('/client/add', body: body);

  static Future<Response> forgot(Map<String, dynamic> body) async =>
      await RootApi.Post('/client/forgetpassword', body: body);

  static Future<Response> updateUser(Map<String, dynamic> body) async =>
      await RootApi.Post('/client/update', body: body, verifyBase: true);

  static Future<Response> addGeolocation(Map<String, dynamic> body) async =>
      await RootApi.Post('/geolocation/add', body: body, verifyBase: true);

  static Future<Response> deleteGeolocatin(Map<String, dynamic> body) async =>
      await RootApi.Post('/geolocation/delete', body: body, verifyBase: true);

  static Future<Response> listGeolocation(Map<String, dynamic> body) async =>
      await RootApi.Post('/geolocation/get-lst', body: body, verifyBase: true);

  static Future<Response> updateGeolocation(Map<String, dynamic> body) async =>
      await RootApi.Post('/geolocation/update', body: body, verifyBase: true);

  static Future<Response> getCategories(Map<String, dynamic> body) async =>
      await RootApi.Post('/catproduct/get-lst', body: body);

  static Future<Response> getElements(Map<String, dynamic> body) async =>
      await RootApi.Post('/filtrohomeapp/get-lst', body: body);

  static Future<Response> getProductsByLocal(Map<String, dynamic> body) async =>
      await RootApi.Post('/product/local/get-lst', body: body);

  static Future<Response> getCardByClient(Map<String, dynamic> body) async =>
      await RootApi.Post('/card/get-lst', body: body);

  static Future<Response> deleteCard(Map<String, dynamic> body) async =>
      await RootApi.Post('/card/delete', body: body);

  static Future<Response> processOrderClient(Map<String, dynamic> body) async =>
      await RootApi.Post('/order/processorder', body: body);

  static Future<Response> getOrdersByClient(Map<String, dynamic> body) async =>
      await RootApi.Post('/order/getlistxclient', body: body);

  static Future<Response> checkVersion(Map<String, dynamic> body) async =>
      await RootApi.Post('/appversion/check', body: body);

  ////////////////////// New apis
  static Future<Response> addOrUpdateFavourite(
          Map<String, dynamic> body) async =>
      await RootApi.Post('/favourite/addorupdate', body: body);

  static Future<Response> get(Map<String, dynamic> body) async =>
      await RootApi.Post('/client/get', body: body);

  static Future<Response> updateStateNotificationFavourite(
          Map<String, dynamic> body) async =>
      await RootApi.Post('/notification/updatesilencenotifavourite',
          body: body);

  static Future<Response> validateCoupon(Map<String, dynamic> body) async =>
      await RootApi.Post('/coupon/app/validate', body: body);

  static Future<Response> saveCouponUser(Map<String, dynamic> body) async =>
      await RootApi.Post('/coupon/app/addcouponuser', body: body);

  static Future<Response> listCouponUser(Map<String, dynamic> body) async =>
      await RootApi.Post('/coupon/app/listcouponperuser', body: body);

  static Future<Response> addPushtoken(Map<String, dynamic> body) async =>
      await RootApi.Post('/notification/addpushtokenapp', body: body);
}
