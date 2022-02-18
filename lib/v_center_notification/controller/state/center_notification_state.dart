import 'package:appclientes/v_center_notification/controller/model/center_notification_model.dart';
import 'package:rxdart/rxdart.dart';

class CenterNotificationState {
  static CenterNotificationState _instance;

  BehaviorSubject<CenterNotificationModel> _centerNotificationState;

  CenterNotificationState._() {
    _centerNotificationState = BehaviorSubject();
  }

  /// REQUEST STREAM METHODS
  get getEvents => _centerNotificationState.stream;

  CenterNotificationModel get getValue =>
      _centerNotificationState?.value ?? null;

  void update(CenterNotificationModel data) => data is CenterNotificationModel
      ? _centerNotificationState.add(data)
      : null;

  get clean {
    _centerNotificationState.add(null);
  }

  factory CenterNotificationState() => _getInstance();

  static CenterNotificationState _getInstance() {
    if (_instance == null) {
      _instance = CenterNotificationState._();
    }
    return _instance;
  }
}
