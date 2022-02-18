import 'package:appclientes/shared/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowDeliveryInfo extends StatelessWidget {
  final Widget child;
  const RowDeliveryInfo({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          color: AppColors.graySoft2,
          border: Border(
            top: BorderSide(
              color: AppColors.graySoft4,
            ),
          )),
      child: child ?? Container(),
    );
  }
}
