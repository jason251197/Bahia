import 'package:appclientes/service/api/api_service.dart';
import 'package:appclientes/v_home/controller/index.dart';
import 'package:flutter/material.dart';

import '../../common.dart';

enum ORDER_VIEW {
  HOME,
  CART,
}

enum ORDER_TYPE { DELIVERY, PICKUP, ALL }

class SwitchOrderOption extends StatefulWidget {
  final ORDER_VIEW type;
  final Function onSwitch;
  final ORDER_TYPE orderType;
  final List<ORDER_TYPE> hideItems;
  const SwitchOrderOption({
    Key key,
    this.type = ORDER_VIEW.HOME,
    this.onSwitch,
    this.hideItems,
    this.orderType,
  }) : super(key: key);

  @override
  _SwitchOrderOptionState createState() => _SwitchOrderOptionState();
}

class _SwitchOrderOptionState extends State<SwitchOrderOption> {
  ORDER_TYPE _option;
  ORDER_TYPE _lastOptionCall;

  List<ORDER_TYPE> hideItems = [];
  // bool get _isDelivery => _option == ORDER_TYPE.DELIVERY;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildIcon(
            AppIcon.path(AppIcon.order, color: Colors.black, height: 18.0),
            ORDER_TYPE.DELIVERY),
        SizedBox(width: 15),
        _buildIcon(
            AppIcon.path(AppIcon.ship, color: Colors.black, height: 18.0),
            ORDER_TYPE.PICKUP),
      ],
    );
  }

  Widget _buildIcon(Widget child, ORDER_TYPE order) {
    final delivery = order == ORDER_TYPE.DELIVERY;

    final isDisabled = hideItems.contains(order);

    final text = delivery ? "Domiclio" : "Para recoger";
    return Tooltip(
      message: isDisabled ? 'Acción deshabilitada' : text,
      child: GestureDetector(
        onTap: () => isDisabled ? null : onChange(order),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color: isDisabled
                ? Colors.white
                : isSelected(order)
                    ? AppColors.yellow
                    : AppColors.graySoft1,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          child: Row(
            children: [
              if (!delivery) child ?? AppIcon.path(AppIcon.lookup),
              if (widget.type == ORDER_VIEW.CART)
                Padding(
                  padding: EdgeInset.horizontal(8.0),
                  child: Texts.black(text),
                ),
              if (delivery) child ?? AppIcon.path(AppIcon.lookup),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initOrderType();
    initHideItems();
    if (widget.type == ORDER_VIEW.HOME)
      _option = HomeEvents.isAllOrder
          ? ORDER_TYPE.ALL
          : HomeEvents.isDelivery
              ? ORDER_TYPE.DELIVERY
              : ORDER_TYPE.PICKUP;
    // else
    //   _option = _isDelivery ? ORDER_TYPE.DELIVERY : ORDER_TYPE.PICKUP;
  }

  void initOrderType() {
    _option = widget.orderType ?? ORDER_TYPE.DELIVERY;
  }

  void initHideItems() {
    if (widget.hideItems is List && widget.hideItems.isNotEmpty) {
      hideItems = widget.hideItems;
      if (hideItems.contains(ORDER_TYPE.DELIVERY)) _option = ORDER_TYPE.PICKUP;
      if (hideItems.contains(ORDER_TYPE.PICKUP)) _option = ORDER_TYPE.DELIVERY;
    }
  }

  void onChange(ORDER_TYPE order) async {
    if (await AppConnectivity.check()) {
      // final isDelivery = order == ORDER_TYPE.DELIVERY;
      setState(() {
        switch (widget.type) {
          case ORDER_VIEW.CART:
            _option = order;

            break;
          case ORDER_VIEW.HOME:
            final orderType = onSelectHome(order);
            handleChange(orderType);

            break;
          default:
        }
        // if (widget.type == ORDER_VIEW.CART)
        // _option = isDelivery ? ORDER_TYPE.DELIVERY : ORDER_TYPE.PICKUP;
      });
      // if (widget.type == ORDER_VIEW.HOME) {}
      if (widget.onSwitch is Function) widget.onSwitch(_option);
    }
  }

  void handleChange(ORDER_TYPE order) {
    final filterState = FilterState();

    filterState.setPreLoading;

    Future.delayed(Duration(milliseconds: 1600), () {
      if (_option == order && _lastOptionCall != order) {
        filterState.reset;
        HomeEvents.onSwitchByOrder(_option);
        _lastOptionCall = order;
        filterState.cancelPreLoading;
      } else if (_option == order && _lastOptionCall == order) {
        filterState.cancelPreLoading;
      }
    });
  }

  ORDER_TYPE onSelectHome(ORDER_TYPE ordertype) {
    switch (_option) {
      case ORDER_TYPE.ALL:
        if (ordertype == ORDER_TYPE.DELIVERY) _option = ORDER_TYPE.PICKUP;
        if (ordertype == ORDER_TYPE.PICKUP) _option = ORDER_TYPE.DELIVERY;
        break;
      case ORDER_TYPE.DELIVERY:
        if (ordertype == ORDER_TYPE.DELIVERY) _option = ORDER_TYPE.PICKUP;
        if (ordertype == ORDER_TYPE.PICKUP) _option = ORDER_TYPE.ALL;
        break;
      case ORDER_TYPE.PICKUP:
        if (ordertype == ORDER_TYPE.DELIVERY) _option = ORDER_TYPE.ALL;
        if (ordertype == ORDER_TYPE.PICKUP) _option = ORDER_TYPE.DELIVERY;
        break;
      default:
    }
    return _option;
  }

  bool isSelected(ORDER_TYPE ordertype) {
    switch (_option) {
      case ORDER_TYPE.ALL:
        return true;
        break;
      case ORDER_TYPE.DELIVERY:
        return ordertype == ORDER_TYPE.DELIVERY;
        break;
      case ORDER_TYPE.PICKUP:
        return ordertype == ORDER_TYPE.PICKUP;
        break;
      default:
        return false;
    }
  }
}
