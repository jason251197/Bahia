part of './api_service.dart';

Dio dio;

class RootApi {
  static const String _get = "GET";
  static const String _post = "POST";
  static const String _put = "PUT";
  static const String _delete = "DELETE";
  static const String _encoded = "ENCODED";
  static const String _baseUri =
      "http://2020planetoliver2050servicesdev.azurewebsites.net/api";
  static const int _connectTimeout = 100000;
  static const int _receiveTimeout = 3000;
  static const String _encoder = "application/x-www-form-urlencoded";
  static const String _authType = "Bearer";
  static const String _authKey = "Authorization";

  static Map<String, dynamic> basicToken = {
    _authKey: "Basic amNhbGRlcm9uMjAyMDoxMjM0NTY3ODk="
  };

  static Map<String, dynamic> get _injectToken {
    Logger.log("inject token", [AppCache.getToken ?? "NO TOKEN"]);
    if (AppCache.verifyToken)
      return {_authKey: _genAuthToken(AppCache.getToken)};
    return null;
  }

  // ignore: non_constant_identifier_names
  static Future<Response> Get(String path) async {
    Response response;
    if (await AppConnectivity.hasConnection) {
      try {
        Logger.log(_get, [path]);
        response = await dio.get(path);
      } catch (err, stack) {
        Logger.err(_get, err, stack);
      }
    }
    return response;
  }

  // ignore: non_constant_identifier_names
  static Future<Response> Post(String path,
      {Map<String, dynamic> body, bool verifyBase = false}) async {
    if (verifyBase && RootApi.hasBasicToken) return null;
    Response response;
    if (await AppConnectivity.hasConnection) {
      try {
        Logger.log(_post, [path, AppConverter.toJson(body)]);
        response = await dio.post(path, data: body);
      } catch (err, stack) {
        Logger.err(_post, err, stack);
        if (response is Response) return response;
      }
    }
    return response;
  }

  // ignore: non_constant_identifier_names
  static Future<Response> Delete(String path,
      {Map<String, dynamic> body}) async {
    Response response;
    if (await AppConnectivity.hasConnection) {
      try {
        Logger.log(_delete, [path]);
        response = await dio.delete(path, data: body);
      } catch (err, stack) {
        Logger.err(_delete, err, stack);
      }
    }
    return response;
  }

  // ignore: non_constant_identifier_names
  static Future<Response> Put(String path, {Map<String, dynamic> body}) async {
    Response response;
    if (await AppConnectivity.hasConnection) {
      try {
        Logger.log(_put, [path]);

        response = await dio.post(path, data: body);
      } catch (err, stack) {
        Logger.err(_put, err, stack);
      }
    }
    return response;
  }

  // ignore: non_constant_identifier_names
  static Future<Response> Encoded(String path,
      {Map<String, dynamic> body}) async {
    Response response;

    if (await AppConnectivity.hasConnection) {
      try {
        Logger.log(_encoded, [path, body]);
        response = await dio.post(
          path,
          data: body,
          options: new Options(contentType: _encoder),
        );
      } catch (err, stack) {
        Logger.err(_encoded, err, stack);
      }
    }
    return response;
  }

  static BaseOptions root = new BaseOptions(
    baseUrl: _baseUri,
    connectTimeout: _connectTimeout,
    receiveTimeout: _receiveTimeout,
    headers: _injectToken ?? basicToken,
  );

  static void setToken(token) {
    dio..options.headers = {_authKey: _genAuthToken(token)};

    Logger.log("HEADERS_UPDATED", [dio.options.headers]);
  }

  static String _genAuthToken(String token) => "$_authType $token";

  static bool get hasBasicToken => dio.options.headers == basicToken;

  static void get removeTokens => dio..options.headers = basicToken;
}
