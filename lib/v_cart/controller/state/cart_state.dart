part of '../index.dart';

class CartState {
  static CartState _instance;
  // static const _maxValue = 99;
  static const _minValue = 1;
  String typePickup;
  num tip;
  num valueCoupon = 0;
  int tipIndex;
  int cardIndex = 0;
  CardModel cardModel;
  CouponValidateModel couponModel;

  ///[_cartState] will manage the Request Events

  BehaviorSubject<List<CartItemModel>> _cartState;

  CartState._() {
    _cartState = BehaviorSubject();
  }

  /// REQUEST STREAM METHODS
  Stream<List<CartItemModel>> get getEvents => _cartState.stream;

  List<CartItemModel> get getValue => _cartState?.value ?? [];

  void update(List<CartItemModel> value) =>
      value is List ? _cartState.add(value) : null;

  void addMore(CartItemModel data) =>
      data is CartItemModel ? update([...getValue, data]) : null;

  void addCoupon(CouponValidateModel data) => couponModel = data;
  CouponValidateModel getCoupon() => couponModel;

  void doAddMore(CartItemModel data) {
    if (getValue.length == 0) {
      CartState().tip =
          (AppParams.tipList[AppParams.tipIndexDefault]); //double.parse
      CartState().tipIndex = AppParams.tipIndexDefault;
      OrderTypeState().setTypePickupImmediately(false);
    }
    final product = findProduct(data);
    if (product is CartItemModel) {
      if (data.product.stock > product.qty)
        sum(product);
      else
        DialogService.validateProductStockMyOrder;
    } else {
      addMore(data);
    }
  }

  CartItemModel findProduct(CartItemModel data) => getValue
      .firstWhere((element) => element.code == data.code, orElse: () => null);

  /// [GETTER - METHODS]
  String get deliveryString => CartEvents.toCOP(delivery);
  int get totalItems => getValue.fold(0, (p, element) => p += element.qty) ?? 0;

  num get delivery =>
      getValue.length > 0 ? getValue.first?.deliveryPrice ?? 0 : 0;

  num get total {
    num total = 0;
    getValue.forEach((element) => total += element.total);
    return total ?? 0;
  }

  get currency {
    final products = getValue;
    if (products.isNotEmpty) return products?.first?.product?.currency ?? '';
    return '';
  }

  num get realPrice {
    num total = 0;
    getValue.forEach((element) => total += element.totalRealPrice);
    return total ?? 0;
  }

  get clean {
    _cartState.add(null);
    CartState().typePickup = AppParams.flagPickUpImmediately;
    CartState().tip =
        0; // double.parse(AppParams.tipList[AppParams.tipIndexDefault]);
    CartState().tipIndex = 0; //AppParams.tipIndexDefault;
    OrderTypeState().setTypePickupImmediately(false);
    FormController.billController.text = '';
    FormController.codeCouponController.text = '';
  }

  factory CartState() => _getInstance();

  static CartState _getInstance() {
    if (_instance == null) {
      _instance = CartState._();
    }
    return _instance;
  }

  void remove(CartItemModel value) async {
    final products = getValue;
    products.removeWhere((element) => element.code == value.code);
    update(products);
    if (products.length == 0) {
      clean;
    }
  }

  void sum(CartItemModel value) {
    if (value.qty < value.product.stock) {
      value.qty++;
      updateAt(value);
    } else {
      DialogService.validateProductStockMyOrder;
    }
  }

  void rest(CartItemModel value) {
    if (value.qty > _minValue) {
      value.qty--;
      updateAt(value);
    }
  }

  void updateAt(CartItemModel value) {
    final products = getValue;
    final index = products.indexOf(value);
    products[index] = value;
    update(products);
  }

  String get getMaxHour =>
      getValue.length > 0 ? getValue.first?.product?.maxPickupTime : null;
/*
  String getMaxPickupTimeCartLater() {
    if (getValue.length > 0) {
      if (getValue.first?.product?.endReopeningTime == null) {
        return getValue.first?.product?.endOpeningTime;
      }
      return getValue.first?.product?.endReopeningTime;
    }
    return '';
  }
*/

  String getMaxPickupTimeCartLater() {
    String maxPickupTimeCartNew;
    final list = CartState().getValue;
    if (list.length == 0) return null;
    for (CartItemModel item in list) {
      if (maxPickupTimeCartNew == null) {
        maxPickupTimeCartNew = item.product.maxPickupTime;
      } else {
        String dateStr;
        dateStr = DateTime.now().toString().substring(0, 10);
        Duration diff =
            DateTime.tryParse(dateStr + " " + maxPickupTimeCartNew + ":00")
                .difference(DateTime.tryParse(
                    dateStr + " " + item.product.maxPickupTime + ":00"));
        if (diff.inSeconds > 0) {
          maxPickupTimeCartNew = item.product.maxPickupTime;
        }
      }
    }
    return maxPickupTimeCartNew;
  }

  void setTypePickup(String type) {
    typePickup = type;
  }

  String get getTypePickup {
    if (typePickup == null) {
      return AppParams.flagPickUpImmediately;
    }
    return typePickup;
  }

  void setTip(num tipAmount) {
    tip = tipAmount;
  }

  //num get getTip => tip;
  num getTip() {
    if (tip == null) {
      return (AppParams.tipList[AppParams.tipIndexDefault]); //double.parse
    }
    return tip;
  }

  void setTipIndex(int index) {
    tipIndex = index;
  }

  //num get getTipIndex => tipIndex;

  num getTipIndex() {
    if (tipIndex == null) {
      return AppParams.tipIndexDefault;
    }
    return tipIndex;
  }

  void setCardIndex(int index) {
    cardIndex = index;
  }

  num getCardIndex() {
    if (cardIndex == null) {
      return 0;
    }
    return cardIndex;
  }

  void setCardModel(CardModel card) {
    cardModel = card;
  }

  CardModel getCardModel() {
    if (cardModel == null) {
      return null;
    }
    return cardModel;
  }

  void setCopunModel(num value) {
    valueCoupon = value;
  }

  num getCopunModel() {
    return valueCoupon;
  }
}
