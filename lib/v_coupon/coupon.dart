import 'package:appclientes/service/navigation/navigation_service.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/v_center_notification/content/check_state.dart';
import 'package:appclientes/v_coupon/content/coupon_history.dart';
import 'package:flutter/material.dart';

class CouponView extends StatelessWidget {
  final Function callback;
  const CouponView({
    Key key,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      text: "Cupones",
      back: () => NavigationService().pop(),
      bottomText: "Valida y revisa los cupones asignados",
      child: CouponHistory(),
    );
  }
}
