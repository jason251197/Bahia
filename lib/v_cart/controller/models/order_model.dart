part of '../index.dart';

class OrderModel {
  List<CartItemModel> cart;
  num total;
  //String cardToken;
  String pay_type;
  num bill_amount;
  String codeclient;
  String card_code;
  String geolocation_code;
  String order_type;
  String type_pickup;
  num tip_amount;
  num delivery_amount;
  String local_code;
  List<OrderModelDetail> orderDetailLst;
  int id_coupon_discount = 0;
  num value_coupon = 0;
  num avaliable_value_coupon = 0;

  //OrderModel({this.cardToken,this.cart,this.total});
  OrderModel(
      {this.codeclient,
      this.pay_type,
      this.bill_amount,
      this.card_code,
      this.geolocation_code,
      this.order_type,
      this.type_pickup,
      this.tip_amount,
      this.delivery_amount,
      this.local_code,
      this.id_coupon_discount,
      this.value_coupon,
      this.orderDetailLst});

  toJson() {
    print(this.orderDetailLst.first.quantity);
    //List<Map<String, dynamic>> orderDetail =
    //this.orderDetailLst != null ? this.orderDetailLst.map((i) => i.toJson()).toList() : null;

    return {
      "codeclient": this.codeclient,
      "pay_type": this.pay_type,
      "bill_amount": this.bill_amount,
      "card_code": this.card_code,
      "geolocation_code": this.geolocation_code,
      "order_type": this.order_type,
      "type_pickup": this.type_pickup,
      "tip_amount": this.tip_amount,
      "delivery_amount": this.delivery_amount,
      "local_code": this.local_code,
      //"orderDetail": orderDetail
    };
  }
  /*
  toJson() => {
    "cart": this.cart,
    "token": this.cardToken,
    "total": this.total,
  };
   */

  static Map<String, dynamic> getOrder(OrderModel order) => {
        //"entity": jsonEncode(order)
        "entity": {
          "codeclient": order.codeclient,
          "pay_type": order.pay_type,
          "bill_amount": order.bill_amount,
          "card_code": order.card_code,
          "geolocation_code": order.geolocation_code,
          "order_type": order.order_type,
          "type_pickup": order.type_pickup,
          "tip_amount": order.tip_amount,
          "delivery_amount": order.delivery_amount,
          "local_code": order.local_code,
          "id_coupon_discount": order.id_coupon_discount,
          "value_coupon": order.value_coupon,
          "avaliable_value_coupon": order.avaliable_value_coupon,
          "orderDetail": [
            for (OrderModelDetail item in order.orderDetailLst)
              {
                "product_code": item.product_code,
                "quantity": item.quantity,
                "unit_price": item.unit_price,
                "type_currency": "COP",
                "subtotal": item.subtotal
              }
          ]
          //"orderDetail": jsonEncode(order.orderDetailLst)
        }
      };
}
