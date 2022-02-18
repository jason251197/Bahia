import 'dart:async';

import 'package:appclientes/v_order/controller/index.dart';
import 'package:appclientes/shared/components/app_bar/controller/app_bar_state.dart';
import 'package:appclientes/v_order/controller/order_controller.dart';
import 'package:appclientes/shared/components/app_loading/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:appclientes/shared/common.dart';

import '../content/build_order.dart';

class BuildOrders extends StatelessWidget {
  //OrderList orderList;
  const BuildOrders(/*this.orderList,*/ {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //if (orderList is! OrderList) return Container();
    return FutureBuilder(
        future: OrderController.loadOrdersAfterClickOrder(),
        // initialData: null,
        builder: (c, v) => handler(v));
  }

  Widget handler(AsyncSnapshot v) {
    if (v.connectionState == ConnectionState.waiting)
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [LoadingWidget()]);
    if (v.hasData && v.data.isNotEmpty)
      return OrderShortList(orders: v.data);
    else if (v.data == null && v.hasData && v.data.isEmpty) return Container();
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Texts.black("Por el momento no tienes pedidos. Anímate a ayudar y ahorrar pidiendo en alguno de nuestros restaurantes disponibles.",
            textAlign: TextAlign.justify,
            fontSize: 13),
      ),
    );
  }
}

class OrderShortList extends StatelessWidget {
  const OrderShortList({
    Key key,
    @required this.orders,
  }) : super(key: key);

  //final List<OrderModel> products;
  final OrderList orders;

  @override
  Widget build(BuildContext context) {
    if (orders is! OrderList) return Container();
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            if (orders?.orders is List)
              ...orders.orders.asMap().entries.map(
                    (e) => BuildOrder(
                  order: e.value,
                  index: e.key,
                  selected: null,//_addressSelected,
                  onPress: null,//_onOrderChange,
                  onLongPress: null,//_openSelectedOrder,
                  onDelete: (OrderModel v) => null,
                ),
              ),
          ],
        ),
    );
    /*return Container(
      height: 180,
      child: ListView.builder(
          itemCount: products.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemBuilder: (c, v) {
            return ProductShortView(products[v]);
          }),
    );*/
  }
}
/*
class ProductShortView extends StatelessWidget {
  final OrderModel product;
  const ProductShortView(
      this.product, {
        Key key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (product is! OrderModel) return Container();
    return null;
  }
}
*/
//---------------------------------------
/*
class OrderRegistered extends StatefulWidget {
  final bool useView;
  const OrderRegistered({
    Key key,
    this.useView = false,
  }) : super(key: key);

  @override
  _OrderRegisteredState createState() => _OrderRegisteredState();
}

class _OrderRegisteredState extends State<OrderRegistered> {
  OrderList orderList;
  OrderModel _orderSelected;
  StreamSubscription streamSubscription;

  @override
  void initState() {
    buildOrders;
    streamSubscription = AddressState().onUpdateEvents.listen(onEventUpdate);
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useView) return _buildOrders;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: _buildOrders,
    );
  }

  Column get _buildOrders {
    return Column(
      children: [
        if (orderList?.orders is List)
          ...orderList.orders.asMap().entries.map(
                (e) => BuildOrder(
                  order: e.value,
                  index: e.key,
                  selected: null,//_addressSelected,
                  onPress: _onOrderChange,
                  onLongPress: _openSelectedOrder,
                  onDelete: (OrderModel v) => null,
                ),
              ),
      ],
    );
  }

  void _onOrderChange(OrderModel current) async {

  }

  void _openSelectedOrder(OrderModel current) async {

  }

  void get rebuild {
    setState(() => buildOrders);
  }

  void get buildOrders {
    //_orderSelected = AddressCache?.getCurrentAddress;
    //AddressState().update(_orderSelected);
    orderList = OrderController.loadOrders;

  }

  void onEventUpdate(event) => event is bool ? rebuild : null;
}
*/
