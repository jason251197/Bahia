part of '../index.dart';

class OrderModelDetail {

  String product_code;
  num quantity;
  num unit_price;
  num subtotal;
  String type_currency;



  OrderModelDetail({this.product_code,this.quantity,this.unit_price,this.type_currency,this.subtotal});


  toJson() => {
    "product_code": this.product_code,
    "quantity": this.quantity,
    "unit_price": this.unit_price,
    "type_currency": this.type_currency,
    "subtotal": this.subtotal,
  };

  factory OrderModelDetail.fromJson(Map<String, dynamic> json) => OrderModelDetail(
    product_code: json["product_code"],
    quantity: json["quantity"],
    unit_price: json["unit_price"],
    type_currency: json["type_currency"],
    subtotal: json["subtotal"]
  );

}
