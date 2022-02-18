import 'package:appclientes/shared/common.dart';
import 'package:appclientes/v_home/controller/index.dart';

import 'package:flutter/material.dart';

import 'tag_on_sale.dart';

enum IMG_DETAIL { FOOD, RESTAURANT, COMMON }

class BuildItemDetails extends StatelessWidget {
  final num paddingHBody;
  final num paddingBottom;
  final IMG_DETAIL type;
  final ProductModel product;
  final LocalModel local;

  const BuildItemDetails({
    Key key,
    this.paddingHBody = 3.0,
    this.paddingBottom = 10.0,
    this.type = IMG_DETAIL.COMMON,
    this.product,
    this.local,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (product is! ProductModel && local is! LocalModel) return Container();

    var isProduct = product is ProductModel;
    var isLocal = local is LocalModel;

    var title = isProduct
        ? product.localName
        : isLocal
            ? local.localName
            : '';

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: type != IMG_DETAIL.COMMON ? 70 : 60,
        margin: EdgeInset.bottom(paddingBottom),
        child: Container(
          color: AppColors.black,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInset.horizontal(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Texts.whiteBold(
                              title,
                              overflow: TextOverflow.ellipsis,
                              fontSize:
                                  (type == IMG_DETAIL.RESTAURANT) ? 23 : 15.5,
                            ),
                            (type == IMG_DETAIL.RESTAURANT)
                                ? Row(
                                    children: [
                                      Texts.white("A solo", fontSize: 15.5),
                                      Texts.whiteBold(
                                          " " +
                                              (isLocal
                                                  ? local.distance
                                                  : product?.distance ?? ''),
                                          fontSize: 17),
                                    ],
                                  )
                                : Texts.white(
                                    isLocal
                                        ? local.doValidateSchedule2
                                        //? local.isClosed ? "Cerrado"/*local.openingTime*/ : local.doValidateSchedule
                                        : product.productName,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize:
                                        (type == IMG_DETAIL.FOOD) ? 20 : 15.5,
                                  ),
                          ],
                        ),
                      ),
                      if (type != IMG_DETAIL.RESTAURANT)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Texts.white(
                                isLocal || (type == IMG_DETAIL.FOOD)
                                    ? "A solo"
                                    : product.initialPrice,
                                fontSize: 15.5,
                                decoration: (type == IMG_DETAIL.FOOD)
                                    ? null
                                    : isProduct
                                        ? TextDecoration.lineThrough
                                        : null),
                            Texts.whiteBold(
                              isLocal
                                  ? local?.distance ?? ''
                                  : (type == IMG_DETAIL.FOOD)
                                      ? product?.distance ?? ''
                                      : product?.price ?? '',
                              fontSize: 17,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              (type == IMG_DETAIL.FOOD)
                  ? Container()
                  : OnSaleTag(
                      fit: isProduct,
                      color: isProduct ? product.background : AppColors.yellow,
                      paddingH: paddingHBody,
                      text: isProduct ? product.discount : local.sales,
                      fontSize: isProduct ? 20 : 15,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
