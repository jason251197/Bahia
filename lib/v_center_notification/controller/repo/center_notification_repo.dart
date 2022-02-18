import 'package:appclientes/service/services.dart';
import 'package:appclientes/v_center_notification/controller/model/center_notification_model.dart';
import 'package:appclientes/v_center_notification/controller/state/center_notification_state.dart';

class CenterNotificationRepo {
  static Future<bool> getStateNotification([bool showLoading = true]) async {
    final userClient = SessionService.getCodClient;
    return await ApiService.fetch(
        Apis.get(CenterNotificationModel.getStateClient(userClient)),
        showSuccessDialog: false,
        showLoading: showLoading,
        onSuccessObjectData: (e) => CenterNotificationState()
            .update(CenterNotificationModel.fromJson(e)));
  }

  static Future<bool> saveStateNotification(bool state,
      [bool showLoading = true]) async {
    final userClient = SessionService.getCodClient;
    return await ApiService.fetch(
        Apis.updateStateNotificationFavourite(
            CenterNotificationModel.saveStateClient(userClient, state)),
        showSuccessDialog: false,
        showLoading: showLoading,
        onSuccess: (data) async =>
            await CenterNotificationRepo.getStateNotification());
  }
}
