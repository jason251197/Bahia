import 'package:appclientes/service/navigation/constants/routes.dart';
import 'package:appclientes/shared/components/app_button_switch/button_switch.dart';
import 'package:appclientes/v_home/controller/index.dart';
import 'package:flutter/material.dart';

class SwitchTypes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Buttonswitch(
        onSwitch: onChange,
        indexSelected: HomeEvents.isProduct ? 1 : 0,
        buttons: ["Local", "Producto"],
      ),
    );
  }

  void onChange(int index) {
    HomeEvents.onSwitchTypes(ROUTE_SEARCH.values[index]);
  }
}
