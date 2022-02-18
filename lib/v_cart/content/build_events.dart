import 'package:appclientes/v_cart/controller/index.dart';
import 'package:flutter/material.dart';

class CartRender extends StatelessWidget {
  final Function child;

  CartRender({this.child});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: CartState().getEvents,
        builder: (context, snapshot) {
          return child() ?? Container();
        });
  }
}
