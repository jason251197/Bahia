import 'package:appclientes/v_order/controller/index.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/helpers/converter.dart';
import 'package:appclientes/shared/components/app_tag/tag_custom.dart';
import 'package:flutter/material.dart';

class BuildOrder extends StatelessWidget {
  final OrderModel order;
  final int index;
  final OrderModel selected;
  final Function(OrderModel) onPress;
  final Function(OrderModel) onDelete;
  final Function(OrderModel) onLongPress;

  const BuildOrder({
    Key key,
    this.order,
    this.index,
    this.selected,
    this.onPress,
    this.onDelete,
    this.onLongPress,
  }) : super(key: key);


  static String toCOP(num value, String loadCurrency) =>
      AppConverter.numToMoney(value, loadCurrency, " ");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => null,//onPress(order),
      onLongPress: () => null,//onLongPress(order),
      child: Container(
        margin: EdgeInset.vertical(5.0),
        child: EdgeInset.appDecoration(
          radius: BorderRadius.circular(8),
          border: Border.all(
              width: 1,
              color: AppColors.graySoft1
          ),
          vertical: 10,
          horizontal: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    color: AppColors.gray,
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.83,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.48,
                              child: Texts.blackBold(order.local.localName, maxLines: 2,fontSize: 13, overflow: TextOverflow.ellipsis,),
                            ),
                            Texts.black(order.datehoursorder, fontSize: 13),
                          ],
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.83,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Texts.black(order.order_code, fontSize: 13)
                              ],
                            ),
                            Column(
                              children: [
                                Texts.black(toCOP(order.total,AppConverter.COP_SYMBOL), fontSize: 13)
                              ],
                            ),
                            Column(
                              children: [
                                CustomTag(
                                    order.state_order,
                                    90,
                                    Alignment.center,
                                    2,
                                    10,
                                    13,
                                    order.state_order == 'Pendiente' ? AppColors.blue : AppColors.yellow,
                                    'blackBold'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              /*
              XButton(
                onDelete: onDelete,
                model: address,
              ),
              */
            ],
          ),
        ),
      ),
    );
  }
}

