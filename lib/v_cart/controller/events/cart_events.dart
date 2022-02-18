part of '../index.dart';

class CartEvents {
  static const _idty = "cart_events";
  static void log(value) => Logger.log(_idty, [value]);

  static String get loadCurrency {
    try {
      return CartState()?.currency;
    } catch (err) {}
    return '';
  }

  static String toCOP(num value) =>
      AppConverter.numToMoney(value, loadCurrency ?? '', " ");

  static const _payAlert =
      "No has seleccionado ningún medio de pago.\nHazlo para finalizar tu compra.";

  static const _removeAlert =
      "¿Está seguro de querer eliminar el producto de su carrito de compras?";

  static bool get hasToken => AppCache.verifyToken;

  static void doPay(ORDER_TYPE order, CardModel cardModel) async {
    if (await AppConnectivity.check()) {
      await Fake.loading;

      if (!hasToken) return DialogService.showNotRegistered;
      if (cardModel is! CardModel)
        return await DialogService.simpleDialog(_payAlert);

      List<OrderModelDetail> orderDetailList = <OrderModelDetail>[];

      String maxPickupTimeCart = null;
      final list = CartState().getValue;
      final address = AddressState().getValue;
      bool passValidation = true;
      bool success = false;
      bool errorValidacion = false;
      HeaderResponseModel genericResponseModel = new HeaderResponseModel();
      double billAmount = 0;
      double totalOrder = 0;
      double deliveryAmount = 0;
      CouponValidateModel coupon = CouponState().getValue;

      if (order == ORDER_TYPE.DELIVERY) {
        deliveryAmount = CartState().delivery;
      }

      if (cardModel.cardCode == 'x') {
        billAmount = getBillAmount();
        totalOrder = CartState().total + deliveryAmount + CartState().getTip();

        if (coupon.id != null) {
          if (billAmount == 0 && coupon.value < totalOrder) {
            return DialogService.simpleDialog(
                'Ingrese el monto con el que vas a pagar');
          }
          if ((totalOrder - coupon.value) > billAmount) {
            return DialogService.simpleDialog(
                'El monto ingresado es inferior\nal valor del pedido');
          }
        } else {
          if (billAmount == 0 && totalOrder != 0) {
            return DialogService.simpleDialog(
                'Ingrese el monto con el que vas a pagar');
          }
          if (totalOrder > billAmount) {
            return DialogService.simpleDialog(
                'El monto ingresado es inferior\nal valor del pedido');
          }
        }

        if (billAmount - totalOrder > AppParams.maxAmountAboveOrder) {
          return DialogService.simpleDialog(
              'El monto ingresado supera\nel máximo establecido');
        }
      }

      for (CartItemModel item in list) {
        OrderModelDetail orderDetail = OrderModelDetail()
          ..product_code = item.code
          ..quantity = item.qty
          ..unit_price = item.product.finalPrice
          ..type_currency = AppConverter.COP
          ..subtotal = item.qty * item.product.finalPrice;
        orderDetailList.add(orderDetail);

        if (order == ORDER_TYPE.PICKUP &&
            CartState().getTypePickup == AppParams.flagPickUpLater) {
          maxPickupTimeCart = getMaxPickupTimeCart(
              maxPickupTimeCart, item.product.maxPickupTime);
        }
      }

      if (order == ORDER_TYPE.PICKUP &&
          CartState().getTypePickup == AppParams.flagPickUpLater) {
        String maxPickupTime = CartState().getMaxPickupTimeCartLater();
        passValidation =
            validateMaxPickupTimeCart(maxPickupTimeCart, maxPickupTime);
      }

      if (passValidation) {
        //print( CartState().getTip);

        final payoutOrder = new OrderModel()
          ..codeclient = cardModel.codeclient
          ..pay_type = cardModel.cardCode == 'x'
              ? AppParams.payWitchCash
              : AppParams.payWithCard
          ..bill_amount = cardModel.cardCode == 'x' ? billAmount : 0
          ..card_code = cardModel.cardCode
          ..geolocation_code = address.code //"20112020002008503"
          ..order_type = order == ORDER_TYPE.DELIVERY
              ? AppParams.flagDelivery
              : AppParams.flagPickUp
          ..type_pickup = order == ORDER_TYPE.PICKUP
              ? CartState().getTypePickup
              : AppParams.flagPickUpLater
          ..tip_amount = CartState().getTip()
          ..delivery_amount = deliveryAmount
          ..local_code = list.first.product.localCode
          // ..total = total;
          ..orderDetailLst = orderDetailList;

        if (coupon.id != null) {
          payoutOrder.id_coupon_discount = coupon.id;
          payoutOrder.value_coupon = coupon.value;
          payoutOrder.avaliable_value_coupon = coupon.avaliable;
        }
        genericResponseModel = await CartRepository.sendPayment(payoutOrder);
        success = genericResponseModel.status;
      } else {
        errorValidacion = true;
      }

      if (success) {
        switch (order) {
          case ORDER_TYPE.DELIVERY:
            String msg = list.first.product.minDeliveyTime +
                " a " +
                list.first.product.maxDeliveyTime;
            await DialogService.showDeliveryDialog(msg);
            break;
          case ORDER_TYPE.PICKUP:
            if (CartState().getTypePickup == AppParams.flagPickUpLater) {
              await DialogService.showPickUpDialog(maxPickupTimeCart);
            } else {
              await DialogService.showConfirmOrderDialog(
                  genericResponseModel.description);
            }
            break;
          default:
        }
        //OrderController.loadOrdersAfterPay(cardModel.codeclient);
        HomeEvents.reload();
        CartState().clean;
        CouponState().clean;
      } else {
        if (!errorValidacion) {
          await DialogService.errorDialog(genericResponseModel.description);
          if (genericResponseModel.code == "0002" ||
              genericResponseModel.code == "0003") {
            //dedos o cambio en bd
            HomeEvents.reloadLocalWithProducts();
            CartState().clean;
            CouponState().clean;
          } else {
            CouponState().clean;
            HomeEvents.reload();
          }
        } else {
          CouponState().clean;
          await DialogService.errorDialog(
              "No puedes comprar un producto fuera de hora de cierre del Local");
        }
      }
    }
  }

  static String getMaxPickupTimeCart(
      String maxPickupTimeCart, String maxPickupTime) {
    String maxPickupTimeCartNew;
    if (maxPickupTimeCart == null) {
      maxPickupTimeCartNew = maxPickupTime;
    } else {
      String dateStr;
      dateStr = DateTime.now().toString().substring(0, 10);
      Duration diff = DateTime.tryParse(
              dateStr + " " + maxPickupTimeCart + ":00")
          .difference(DateTime.tryParse(dateStr + " " + maxPickupTime + ":00"));
      if (diff.inSeconds > 0) {
        maxPickupTimeCartNew = maxPickupTime;
      } else {
        maxPickupTimeCartNew = maxPickupTimeCart;
      }
    }
    return maxPickupTimeCartNew;
  }

  static bool validateMaxPickupTimeCart(
      String maxPickupTimeCart, String maxPickupTime) {
    String dateStr;
    dateStr = DateTime.now().toString().substring(0, 10);
    Duration diff = DateTime.tryParse(dateStr + " " + maxPickupTimeCart + ":00")
        .difference(DateTime.tryParse(dateStr + " " + maxPickupTime + ":00"));
    if (diff.inSeconds > 0) {
      return false; // se puede comprar
    } else {
      return true; // no se puede comprar
    }
  }

  static double getBillAmount() {
    String billAmount = FormController.billController.text;
    if (!billAmount.isEmpty) {
      billAmount = billAmount.replaceAll(' ', '');
      billAmount = billAmount.replaceAll('.', '');
      return double.parse(billAmount);
    }
    return 0;
  }

  static void remove(CartItemModel value) async {
    if (CartState().getValue.length == 1) {
      if (await DialogService.cancelOrderDialog("")) {
        HomeEvents.reload();
        CartState().clean;
        CouponState().clean;
      }
    } else {
      if (await DialogService.yesNoDialog(_removeAlert))
        CartState().remove(value);
    }
  }

  static bool isCartEmpty() => CartState().getValue.isEmpty;
}
