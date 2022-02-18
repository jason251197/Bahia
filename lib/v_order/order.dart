import 'package:appclientes/shared/common.dart';
import 'package:flutter/material.dart';
import 'package:appclientes/v_order/content/order_registered.dart';

class OrderView extends StatelessWidget {
  final Function callback;
  const OrderView({
    Key key,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppViews.common(
      text: "Mis Pedidos",
      back: callback,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 10),
          //OrderRegistered(),
          BuildOrders(),
        ],
      ),
    );
  }
}
