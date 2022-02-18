import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/components/app_button_switch/switch_option.dart';
import 'package:appclientes/v_cart/controller/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appclientes/shared/constants/params.dart';
import 'package:appclientes/v_cart/controller/state/order_type_state.dart';

class DeliveryOption extends StatefulWidget {
  const DeliveryOption({
    Key key,
  }) : super(key: key);

  @override
  _DeliveryOptionState createState() => _DeliveryOptionState();
}

class _DeliveryOptionState extends State<DeliveryOption> {
  final Color activeColor = Color.fromARGB(255, 52, 199, 89);
  bool _active = OrderTypeState().getTypePickupImmediately;
  String _maxHour = CartState().getMaxPickupTimeCartLater();

  void onChange(bool v) {
    setState(() {
      _active = v;
    });
    try {
      if (_active) {
        final maxHour = CartState().getMaxPickupTimeCartLater(); //.getMaxHour;
        _maxHour = maxHour ?? '';
        CartState().setTypePickup(AppParams.flagPickUpLater);
        OrderTypeState().setTypePickupImmediately(true);
      } else {
        _maxHour = '';
        CartState().setTypePickup(AppParams.flagPickUpImmediately);
        OrderTypeState().setTypePickupImmediately(false);
      }
    } catch (_) {
      _maxHour = '';
      CartState().setTypePickup(AppParams.flagPickUpLater);
      OrderTypeState().setTypePickupImmediately(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_active){
      _maxHour ='';
    }
    return Column(
      children: [
        EdgeInset.appPadding(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 3, child: _buildText("Recoger de inmediato", false)),
              Expanded(
                child: Transform.scale(
                  scale: 0.6,
                  child: Theme(
                    data: ThemeData(),
                    child: ShaderMask(
                      child: CupertinoSwitch(
                        value: _active,
                        trackColor: AppColors.black,
                        activeColor: AppColors.black,
                        onChanged: onChange,
                      ),
                      shaderCallback: (r) {
                        return LinearGradient(
                          colors: [AppColors.yellow, AppColors.yellow],
                        ).createShader(r);
                      },
                    ),
                  ),
                ),
              ),
              Flexible(
                  flex: 3, child: _buildText("Recoger más tarde   ", true)),
            ],
          ),
        ),
        if (_maxHour != null && _maxHour.isNotEmpty)
          Container(
            color: AppColors.graySoft2,
            alignment: Alignment.center,
            child: EdgeInset.appPadding(
                horizontal: 10.0,
                vertical: 10.0,
                child: Texts.black(
                    'Su horario tope de recogo será a las $_maxHour Hrs',
                    textAlign: TextAlign.center)),
          ),
      ],
    );
  }

  Widget _buildText(String value, bool side) => (side ? _active : !_active)
      ? Texts.blackBold(value, fontSize: 12.4)
      : Texts.black(value, fontSize: 13);
}

class BuildSwitchOptions extends StatelessWidget {
  final Function(ORDER_TYPE) onSwitch;
  final ORDER_TYPE orderType;
  final ORDER_AVAILABLE available;
  const BuildSwitchOptions({
    Key key,
    this.onSwitch,
    this.available,
    this.orderType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onSwitch is! Function) return Container();
    return Padding(
      padding: EdgeInset.vertical(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (available == ORDER_AVAILABLE.PICKUP)
            SwitchOrderOption(
              key: Key('0'),
              hideItems: [ORDER_TYPE.DELIVERY],
              orderType: orderType,
              onSwitch: onSwitch,
              type: ORDER_VIEW.CART,
            ),
          if (available == ORDER_AVAILABLE.DELIVERY)
            SwitchOrderOption(
              key: Key('1'),
              hideItems: [ORDER_TYPE.PICKUP],
              onSwitch: onSwitch,
              orderType: orderType,
              type: ORDER_VIEW.CART,
            ),
          if (available == ORDER_AVAILABLE.ALL)
            SwitchOrderOption(
              key: Key('2'),
              onSwitch: onSwitch,
              orderType: orderType,
              type: ORDER_VIEW.CART,
            ),
        ],
      ),
    );
  }
}
