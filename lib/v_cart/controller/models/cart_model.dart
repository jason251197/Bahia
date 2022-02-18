part of '../index.dart';

class CartItemModel {
  CartItemModel({
    this.product,
    this.qty,
  });
  ProductModel product;
  int qty;

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        product: ProductModel.fromJson(json["product"]),
        qty: json["qty"],
      );

  Map toJson() => {
        "product": product.toJson() ?? '',
        "qty": qty ?? 0,
        "total": total ?? 0,
      };

  num get deliveryPrice => product?.deliveryPrice ?? 0;
  bool get hasDelivery => product?.flagDelivery ?? false;
  bool get hasPickUp => product?.flagPickup ?? false;

  ORDER_AVAILABLE get orderAvailable {
    if (hasDelivery && !hasPickUp) return ORDER_AVAILABLE.DELIVERY;
    if (!hasDelivery && hasPickUp) return ORDER_AVAILABLE.PICKUP;

    return ORDER_AVAILABLE.ALL;
  }

  num get realPrice => product?.realPrice ?? 0;
  num get price => product?.finalPrice ?? 0;
  int get id => product.id;
  String get code => product.productCode;
  String get money => CartEvents.toCOP(total);
  num get total => price * qty;
  num get totalRealPrice => realPrice * qty;
}

enum ORDER_AVAILABLE {
  DELIVERY,
  PICKUP,
  ALL,
}
