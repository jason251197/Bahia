library api_service;

import 'package:appclientes/cache/cache.dart';
import 'package:appclientes/service/api/model/error_model.dart';
import 'package:appclientes/service/auth/auth_service.dart';
import 'package:appclientes/service/dialog/dialog_service.dart';
import 'package:appclientes/service/logger/logger.dart';
import 'package:appclientes/shared/helpers/converter.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';

part './api_root.dart';
part './apis.dart';

class ApiService {
  static const String _ENTITY = "entity";
  static const String _DATALIST = "datalist";

  // static const _STATUS_SUCCESS = 200;
  static Future<bool> fetch(
    Future<Response> api, {
    Function(Response) onError,
    Function(Response) onSuccess,
    Function(List) onSuccessList,
    Function(Object) onSuccessObject,
    Function(Object) onSuccessObjectData,
    String onErrorMessage,
    bool showLoading = true,
    bool refresh = true,
    bool verifyBasicToken = false,
    bool showSuccessDialog = true,
  }) async {
    bool connection = await AppConnectivity.check();
    String successMessage;
    if (connection) {
      if (verifyBasicToken && RootApi.hasBasicToken) return true;

      if (showLoading) DialogService.showLoading;
      Response response = await api;
      if (showLoading) DialogService.closeLoading;

      if (response is! Response) {
        if (onError is Function) onError(response);

        /// [ERROR IS NOT COMING - API CLIENT FAILS ON READ ON ERROR RESPONSE]
        // String message = ErrorModel.fromJson(response.data).errorDescription;
        // if (message is String) DialogService.simpleDialog(message);
        if (onErrorMessage is String)
          DialogService.simpleDialog(onErrorMessage);

        if (refresh)
          await AuthExpire.refresh;
        else
          await AuthExpire.forceLogout;
      }

      /// [GET SUCCESS MESSAGE]
      try {
        if (response is Response && showSuccessDialog)
          successMessage = response.data['result']['description'] ?? '';
      } catch (err) {
        Logger.err("NOT_SUCCESS_DIALOG", err);
      }

      /// [SHOW DIALOG]
      if (successMessage is String && successMessage.isNotEmpty)
        await DialogService.simpleDialog(successMessage);

      /// [SIMPLE SUCCESS METHOD]
      if (onSuccess is Function && response is Response)
        await onSuccess(response);

      /// [ADVANCED SUCCESS METHODS]
      else if ((onSuccessList is Function ||
              onSuccessObject is Function ||
              onSuccessObjectData is Function) &&
          response is Response) {
        final isValidMap = response.data is Map;

        if (onSuccessObjectData is Function && isValidMap)
          await onSuccessObjectData(response.data[_ENTITY]["data"]);

        if (onSuccessObject is Function && isValidMap)
          await onSuccessObject(response.data[_ENTITY]);
        else if (onError is Function) await onError(response);

        if (onSuccessList is Function && isValidMap) {
          final isValidList = response.data[_ENTITY][_DATALIST] is List;
          if (isValidList)
            await onSuccessList(response.data[_ENTITY][_DATALIST]);
          else if (onError is Function) await onError(response);
        }
      }

      return response is Response;
    }
    return connection;
  }
}

class AppConnectivity {
  /// GET CONNECTIVITY STATUS

  static Future<ConnectivityResult> get connectivityResult async =>
      await (Connectivity().checkConnectivity());

  static Future<bool> get hasConnection async =>
      await connectivityResult != ConnectivityResult.none;

  static Future<bool> check() async {
    /// VALIDATE FOR MOBILE OR WIFI CONNECTION
    ///
    ///
    final hasNetwork = await hasConnection;
    if (!hasNetwork)
      await DialogService.simpleDialog(
          "Por favor revise su conexión a internet");
    return hasNetwork;
  }
}
