import 'package:appclientes/shared/common.dart';
import 'package:appclientes/v_cart/controller/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appclientes/shared/constants/params.dart';

class BuildTip extends StatefulWidget {
  final Function(num) onTipChange;
  final num initial;
  const BuildTip({
    Key key,
    this.onTipChange,
    this.initial,
  }) : super(key: key);

  @override
  _BuildTipState createState() => _BuildTipState();
}

class _BuildTipState extends State<BuildTip> {
  int selected;
  int itemSize = AppParams.tipList.length;

  @override
  void initState() {
    if (widget.initial is num)
      selected = widget.initial.toInt();
    else
      selected =
          itemSize = selected = CartState().getTipIndex(); //itemSize - 2;
    super.initState();
  }

  void onSelectTip(int value) {
    setState(() {
      selected = value;
    });
    CartState().tip = (AppParams.tipList[selected]); //double.parse
    CartState().setTipIndex(selected);
    if (widget.onTipChange is Function) widget.onTipChange(selected);
  }

  @override
  Widget build(BuildContext context) {
    final cry = CartEvents.loadCurrency;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Texts.blackBold("Fee de servicio:", fontSize: 16),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                child: ListView.builder(
                  itemCount: itemSize,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (c, v) => InkWell(
                    onTap: () => onSelectTip(v),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: v == selected
                              ? AppColors.yellow
                              : AppColors.graySoft3,
                          borderRadius: BorderRadius.circular(7.0)),
                      margin: EdgeInset.horizontal(3.0),
                      padding: EdgeInsets.symmetric(horizontal: 1),
                      child: Texts.black(
                          //"$cry $v.000",
                          //"$cry"+AppParams.tipList[v]
                          CartEvents.toCOP(AppParams.tipList[v])),
                    ),
                  ),
                ),
              ),
            ),
            Texts.blackBold(CartEvents.toCOP(AppParams.tipList[selected]),
                fontSize: 16),
          ],
        ),
      ],
    );
  }
}
