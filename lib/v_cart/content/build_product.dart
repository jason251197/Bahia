import 'package:appclientes/shared/common.dart';
import 'package:appclientes/v_cart/controller/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBuy extends StatelessWidget {
  final CartItemModel item;
  final Function(CartItemModel) sum;
  final Function(CartItemModel) rest;
  final Function(CartItemModel) onRemove;

  const ItemBuy({
    Key key,
    @required this.item,
    @required this.sum,
    @required this.rest,
    @required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item is! CartItemModel) return Container();
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.graySoft3,
          ),
        ),
      ),
      padding: EdgeInset.vertical(20.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    fit: FlexFit.tight,
                    child: Texts.black(
                      item.product?.productName ?? '',
                      textAlign: TextAlign.left,
                    )),
                IconButton(
                  onPressed: () => rest(item),
                  icon: Icon(
                    Icons.remove_circle,
                    color: AppColors.gray,
                  ),
                ),
                Texts.blackBold(item.qty.toString()),
                IconButton(
                  onPressed: () => sum(item),
                  icon: Icon(
                    Icons.add_circle,
                    color: AppColors.gray,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            constraints: BoxConstraints(
              minWidth: 100,
            ),
            child: Row(
              children: [
                Texts.blackBold(item.money),
                SizedBox(width: 10),
                XButton(
                  onDelete: () => onRemove(item),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
