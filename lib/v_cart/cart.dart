import 'dart:async';

import 'package:appclientes/cache/cache.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/components/app_button_switch/switch_option.dart';
import 'package:appclientes/shared/helpers/converter.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:appclientes/v_card/content/card_registered.dart';
import 'package:appclientes/v_card/controller/index.dart';
import 'package:appclientes/v_cart/content/build_events.dart';
import 'package:appclientes/v_cart/controller/state/order_type_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import 'content/build_delivery.dart';
import 'content/build_product.dart';
import 'content/build_tip.dart';
import 'content/delivery_options.dart';
import 'controller/index.dart';

class BuyView extends StatefulWidget {
  final Function callback;
  BuyView({this.callback});

  @override
  _BuyViewState createState() => _BuyViewState();
}

class _BuyViewState extends State<BuyView> {
  ORDER_TYPE orderType;
  ORDER_AVAILABLE orderAvailable = ORDER_AVAILABLE.ALL;
  StreamSubscription cartSubscription;
  num tip = 0;
  CardModel _cardToPay;
  CouponValidateModel couponModel = new CouponValidateModel();
  FocusNode myFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return AppViews.common(
      text: "Finaliza tu Compra",
      back: widget.callback,
      child: ListView(
        children: [
          _buildSaleCard,
          _buildDiscount,
          if (CartEvents.hasToken)
            CardRegistered(
              type: CARD_REGISTER.CART,
              selectedCard: onSelectCard,
            ),
          _buildButton
        ],
      ),
    );
  }

  AppCard get _buildSaleCard {
    return AppCard(
      buildOpen: true,
      title: "CARRITO DE COMPRAS",
      paddingH: 0,
      child: Column(
        children: [
          _buildProducts,
          Column(
            children: [
              if (ORDER_TYPE.DELIVERY == orderType) _buildDeliveryAmount,
              CartRender(child: () {
                final items = CartState().getValue.length;
                tip = 0;
                if (items > 0) {
                  tip = CartState()
                      .getTipIndex(); // ?? AppParams.tipIndexDefault;
                  return RowDeliveryInfo(
                      child: BuildTip(
                    onTipChange: addTip,
                    initial: tip,
                  ));
                }
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget get _buildDiscount {
    return AppCard(
      buildOpen: true,
      title: "Descuento",
      paddingH: 0,
      child: Column(
        children: [
          _buildCoupon,
          _buildTotal,
        ],
      ),
    );
  }

  Widget get _buildButton {
    return CartRender(
      child: () => Container(
        padding: EdgeInset.vertical(25.0),
        alignment: Alignment.center,
        child: Buttons.yellow(
          "Pagar",
          disable: CartEvents.isCartEmpty(),
          onClick: () => CartEvents.doPay(
            orderType,
            getSelectedCard(), //_cardToPay,
          ),
        ),
      ),
    );
  }

  Widget get _buildTotal {
    final delivery = CartState().deliveryString;
    return EdgeInset.appPadding(
      vertical: 20.0,
      child: Container(
        child: CartRender(
          child: () => Column(
            children: [
              if (realPrice != null && realPrice != "")
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Texts.blackBold("Precio", fontSize: 16),
                        Texts.black(realPrice,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 13),
                      ],
                    ),
                  ],
                ),
              if (realsubtotal != null && realsubtotal != "")
                Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Texts.blackBold("Precio en Oliver", fontSize: 16),
                        Texts.black(realsubtotal, fontSize: 14),
                      ],
                    ),
                  ],
                ),
              if (ORDER_TYPE.DELIVERY == orderType && realsubtotal != "")
                Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Texts.blackBold("Domicilio", fontSize: 16),
                        Texts.black(delivery, fontSize: 14)
                      ],
                    ),
                  ],
                ),
              if (realsubtotal != null && realsubtotal != "")
                Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Texts.blackBold("Fee de servicio", fontSize: 16),
                        Texts.black(CartEvents.toCOP(CartState().getTip()),
                            fontSize: 14),
                      ],
                    ),
                  ],
                ),
              if (couponModel.value != 0 && couponModel.value != null)
                Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Texts.blackBold("Cupón", fontSize: 16),
                        Texts.black("-" + coupon,
                            fontSize: 14, color: Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              if (realsubtotal != null && realsubtotal != "")
                Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Texts.grayBold("Tu ayuda al planeta", fontSize: 16),
                        Texts.gray("No tiene precio :)", fontSize: 14),
                      ],
                    ),
                  ],
                ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Texts.blackBold("TOTAL A PAGAR", fontSize: 16),
                  Texts.blackBold(totalSale, fontSize: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildCoupon {
    final list = CartState().getValue;
    return CardField(
      paddingH: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Texts.blackBold("Cupón", fontSize: 16),
              SizedBox(width: 20),
              Container(
                width: 150.0,
                height: 45.0,
                child: TextField(
                  enabled: CouponState().getValue.id == null,
                  focusNode: myFocusNode,
                  controller: FormController.codeCouponController,
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 7.0, right: 5.0, top: 15.0, bottom: 12.0),
                    isDense: true,
                    labelText: 'Código',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: FontFamily.REGULAR_ASSISTANT,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Buttons.yellow("Validar",
                  disable: list.isEmpty || CouponState().getValue.id != null
                      ? true
                      : false,
                  fontSize: 12, onClick: () {
                final codeClient = SessionCache.getUser.code;
                CouponModel coupon = new CouponModel(
                    codeCoupon: FormController.codeCouponController.text,
                    codeCliente: codeClient);
                CartRepository.validateCoupon(coupon);
              })
            ],
          ),
        ],
      ),
    );
  }

  Widget get _buildProducts {
    return Column(
      children: [
        EdgeInset.appPadding(
            child: BuildSwitchOptions(
          onSwitch: onSwitchOrderType,
          available: orderAvailable,
          orderType: orderType,
        )),
        if (ORDER_TYPE.PICKUP == orderType) DeliveryOption(),
        EdgeInset.appPadding(
          child: CartRender(
            child: () {
              final list = CartState().getValue;
              return Column(
                children: [
                  for (CartItemModel item in list)
                    ItemBuy(
                      item: item,
                      sum: (_) => CartState().sum(_),
                      rest: (_) => CartState().rest(_),
                      onRemove: (_) => CartEvents.remove(_),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget get _buildDeliveryAmount {
    return CartRender(
      child: () {
        final delivery = CartState().deliveryString;
        return RowDeliveryInfo(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Texts.blackBold("Domicilio:", fontSize: 16),
              Texts.blackBold(delivery, fontSize: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    initOrderType();
    checkAvailability(CartState().getValue);
    CouponState().getEvents.listen((event) {
      setState(() {
        couponModel = event;
      });
      myFocusNode.unfocus();
    });
    cartSubscription =
        CartState().getEvents.listen((event) => checkAvailability(event));
  }

  @override
  void dispose() {
    cartSubscription.cancel();
    super.dispose();
  }

  void initOrderType() {
    if (CartState().getValue.length > 0) {
      orderType = OrderTypeState().getValue;
    } else {
      orderType = ORDER_TYPE.DELIVERY;
    }
    // if (mounted) setState(() {});
  }

  void saveOrderType(ORDER_TYPE orderType) {
    if (CartState().getValue.length > 0) {
      OrderTypeState().update(orderType);
    }
  }

  void checkAvailability(List<CartItemModel> event) {
    if (event is List && event.isNotEmpty) {
      final _orderAvailable = event.first.orderAvailable;
      if (mounted)
        setState(() {
          orderAvailable = _orderAvailable;
        });
      onChangeOrderAvailable(orderAvailable);
    }
  }

  void onChangeOrderAvailable(ORDER_AVAILABLE value) {
    switch (value) {
      case ORDER_AVAILABLE.DELIVERY:
        saveOrderType(ORDER_TYPE.DELIVERY);
        orderType = ORDER_TYPE.DELIVERY;
        break;
      case ORDER_AVAILABLE.PICKUP:
        saveOrderType(ORDER_TYPE.PICKUP);
        orderType = ORDER_TYPE.PICKUP;
        break;
      default:
        if (mounted) setState(() {});
    }
  }

  void onSwitchOrderType(ORDER_TYPE newType) {
    saveOrderType(newType);
    if (mounted) setState(() => orderType = newType);
  }

  void addTip(num number) => setState(() => tip = number);

  //void onSelectCard(CardModel card) => setState(() => _cardToPay = card);

  void onSelectCard(CardModel card) {
    //_cardToPay = CartState().getCardModel();
  }

  CardModel getSelectedCard() {
    return CartState().getCardModel();
  }

  get totalAmount {
    if (CartState().getValue.length == 0) return 0;
    if (orderType == ORDER_TYPE.DELIVERY) {
      num _total =
          CartState().total + CartState().delivery + CartState().getTip();
      if (_total <= (couponModel.value == null ? 0 : couponModel.value)) {
        couponModel.avaliable =
            (couponModel.value == null ? 0 : couponModel.value) - _total;
        CouponState().update(couponModel);
        return 0;
      } else {
        return _total - (couponModel.value == null ? 0 : couponModel.value);
      }
    }
    num _total = CartState().total + CartState().getTip();
    if (_total <= (couponModel.value == null ? 0 : couponModel.value)) {
      couponModel.avaliable =
          (couponModel.value == null ? 0 : couponModel.value) - _total;
      CouponState().update(couponModel);
      return 0;
    } else {
      return _total - (couponModel.value == null ? 0 : couponModel.value);
    }
  }

  get realTotal {
    if (CartState().getValue.length == 0) return 0;
    if (orderType == ORDER_TYPE.DELIVERY) {
      if (CartState().realPrice == 0) return 0;
      return (CartState().realPrice);
    }
    return (CartState().realPrice);
  }

  get subtotal {
    if (CartState().getValue.length == 0) return 0;
    return (CartState().total);
  }

  String get coupon =>
      couponModel.value == 0 ? "0" : CartEvents.toCOP(couponModel.value);
  String get totalSale => realTotal == 0 ? "0" : CartEvents.toCOP(totalAmount);
  String get realPrice => realTotal == 0 ? "" : CartEvents.toCOP(realTotal);
  String get realsubtotal => realTotal == 0 ? "" : CartEvents.toCOP(subtotal);
}
