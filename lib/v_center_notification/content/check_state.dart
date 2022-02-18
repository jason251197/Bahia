import 'package:appclientes/shared/common.dart';
import 'package:appclientes/v_center_notification/controller/repo/center_notification_repo.dart';
import 'package:appclientes/v_center_notification/controller/state/center_notification_state.dart';
import 'package:flutter/material.dart';

class CheckState extends StatefulWidget {
  const CheckState({Key key}) : super(key: key);

  @override
  _CheckStateState createState() => _CheckStateState();
}

class _CheckStateState extends State<CheckState> {
  bool _checkbox = false;

  @override
  void initState() {
    super.initState();
    getState();
  }

  getState() async {
    await CenterNotificationRepo.getStateNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: CenterNotificationState().getEvents,
        builder: (c, v) {
          final value = CenterNotificationState().getValue;
          _checkbox = value != null ? value.stateNotificationFavourite : false;
          return GestureDetector(
            onTap: () async => {
              await CenterNotificationRepo.saveStateNotification(!_checkbox)
            },
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _checkbox
                          ? Icons.notifications_active
                          : Icons.notifications_off,
                      size: 200,
                      color: AppColors.yellow,
                    ),
                    Texts.blackBold(
                        'Notificaciones ${_checkbox ? 'activas' : 'inactivas'}, toca para ${_checkbox ? 'inactivar' : 'activar'}')
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
