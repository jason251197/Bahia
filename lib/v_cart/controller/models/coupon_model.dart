part of '../index.dart';

class CouponModel {
  num idCouponDiscount;
  num avaliableValue;
  num value;
  num idOrder;
  String codeCliente;
  String codeCoupon;

  CouponModel(
      {this.idCouponDiscount,
      this.avaliableValue,
      this.value,
      this.idOrder,
      this.codeCliente,
      this.codeCoupon});

  Map toJson() {
    return {
      "id_coupon_discount": this.idCouponDiscount,
      "avaliable_value": this.avaliableValue,
      "id_order": this.idOrder,
      "code_cliente": this.codeCliente,
      "code_coupon": this.codeCoupon,
    };
  }

  static Map<String, dynamic> coupon(CouponModel c) => {
        "entity": {
          "id_coupon_discount": c.idCouponDiscount,
          "avaliable_value": c.avaliableValue,
          "id_order": c.idOrder,
          "code_cliente": c.codeCliente,
          "code_coupon": c.codeCoupon,
        }
      };
}
