import 'package:appclientes/service/navigation/navigation_service.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/v_center_notification/content/check_state.dart';
import 'package:flutter/material.dart';

class CenterNotificationView extends StatelessWidget {
  final Function callback;
  const CenterNotificationView({
    Key key,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      text: "Centro de Notificaciones",
      back: () => NavigationService().pop(),
      bottomText: "Configurar notificaciones de los favoritos",
      child: CheckState(),
    );
  }
}
