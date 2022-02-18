part of '../index.dart';

class OrderModel {

  String codeclient;
  String order_code;
  String fechaPedido;
  String state_order;
  String datehoursorder;
  num total;
  LocalModel local;

  OrderModel({
    this.codeclient,
    this.order_code,
    this.state_order,
    this.datehoursorder,
    this.total,
    this.local
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      order_code: json["order_code"] ?? "",
      state_order: json["state_order"] ?? "",
      datehoursorder: json["datehoursorder"] ?? "",
      total: json["total"] ?? "",
      local: LocalModel.fromJson(json["local"]),
    );
  }

  static Map<String, dynamic> getOrderList(codClient) => {
    "entity": {
      "order_code": "x",
      "codeclient": codClient
    }
  };

  toJson() {
    return {
      "codeclient": this.codeclient,
      "order_code": this.order_code,
      "state_order": this.state_order,
      "datehoursorder": this.datehoursorder,
      "total": this.total,
      "local": local.toJson() ?? '',
    };
  }

  static Map<String, dynamic> getOrder(OrderModel order) => {
    "entity": {
      "codeclient": order.codeclient,
      "order_code": order.order_code,
      "state_order": order.state_order,
      "datehoursorder": order.datehoursorder,
      "total": order.total,
      "local": {
          "local_name": order.local.localName,
        }
    }
  };

}

class OrderList {
  List<OrderModel> orders = <OrderModel>[];
  OrderList({this.orders});

  Map toJson() => {"datalist": orders};

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
    orders: List<OrderModel>.from(
        json["datalist"].map((a) => OrderModel.fromJson(a))),
  );

  List<OrderModel> get getOrders => orders ?? [];

  get isNotEmpty => orders is List<OrderModel> && orders.isNotEmpty;
}
