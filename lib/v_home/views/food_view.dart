import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/components/app_navigation_bottom_bar/navigation_bottom_bar.dart';

import 'package:flutter/material.dart';

import '../content/item.dart';
import '../content/item_details.dart';
import '../content/tag_on_sale.dart';
import '../content/item_schedule.dart';
import '../controller/index.dart';

class FoodView extends StatelessWidget {
  final ProductModel product;
  final bool byPassBack;

  FoodView(this.product, [this.byPassBack = false]);

  @override
  Widget build(BuildContext context) {
    if (product is! ProductModel) return Container();

    return WillPopScope(
      onWillPop: () => HomeEvents.onBackProduct(product, byPassBack),
      child: AppContainer(
        bottomNavigation: BottomNavigation(
          onChange: HomeEvents.onSelectNav,
          type: BOTTOM_NAV.STACK,
        ),
        back: () => HomeEvents.onBackProduct(product, byPassBack),
        bottomText: "Descripción",
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            BuildItem(
              height: 280,
              type: IMG_DETAIL.FOOD,
              product: product,
            ),
            Container(
              color: AppColors.darkGray2,
              padding: EdgeInset.horizontal(0.0),
              child: Row(
                children: [
                  Expanded(
                    child: EdgeInset.appPadding(
                      vertical: 20.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLines("Stock", "${product.stock} Unidades"),
                          //if (product.flagPickup)
                          _buildLines("Hora máxima de compra",
                              product.maxBuyTime + " horas"),
                          if (product.flagPickup)
                            _buildLines("Hora tope de Recojo",
                                product.maxPickupTime + " horas"),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      if (product.flagDelivery)
                        EdgeInset.appPadding(
                            horizontal: product.flagPickup ? 0.0 : 8.0,
                            child: AppIcon.path(AppIcon.order,
                                color: Colors.white)),
                      if (product.flagPickup)
                        EdgeInset.appPadding(
                            horizontal: 8.0,
                            child: AppIcon.path(AppIcon.ship,
                                color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            EdgeInset.appPadding(
              horizontal: 15.0,
              vertical: 15.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EdgeInset.appPadding(
                      vertical: 10.0, horizontal: 0, child: Texts.grayBold('')),
                  Texts.black(product?.description ?? '',
                      textAlign: TextAlign.justify),
                ],
              ),
            ),
            EdgeInset.appPadding(
              horizontal: 10,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FittedBox(
                            child: Texts.black('Precio Normal:', fontSize: 16)),
                        FittedBox(
                            child: Texts.blackBold('Sólo en Planet Oliver:',
                                fontSize: 17)),
                      ],
                    ),
                  ),
                  EdgeInset.appPadding(
                    horizontal: 20.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Texts.black(product.initialPrice,
                            decoration: TextDecoration.lineThrough),
                        Texts.blackBold(product.price),
                      ],
                    ),
                  ),
                  OnSaleTag(
                    color: product.background ?? AppColors.yellow,
                    //text: product.discountRate.toString() + "%",
                    text: product.discount,
                    fontSize: 20,
                    paddingH: 20,
                    paddingV: 15,
                  ),
                ],
              ),
            ),
            BuildSchedule(
              url: product.urlInstagram,
              phone: product.localPhone,
              initHour: product.doInitSchedule,
              endHour: product.endSchedule,
              isClosed: product.isClosed,
              address: product.address,
              latitude: product.latitude,
              longitude: product.longitude,
            ),
            Container(
                padding: EdgeInset.bottom(30.0),
                alignment: Alignment.center,
                child: Buttons.yellow(
                  "Pídelo Ahora",
                  onClick: () => HomeEvents.addProduct(product),
                  disable: product.stock == 0 || product.isClosed,
                )),
          ],
        ),
      ),
    );
  }

  Row _buildLines(String lead, String text) {
    return Row(
      children: [
        Texts.grayLight("$lead: ", fontSize: 15),
        Texts.whiteBold("$text", fontSize: 15),
      ],
    );
  }
}
