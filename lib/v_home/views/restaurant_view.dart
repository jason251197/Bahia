import 'package:appclientes/service/dialog/dialog_service.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/components/app_navigation_bottom_bar/navigation_bottom_bar.dart';
import 'package:appclientes/v_home/content/favourite_icon.dart';
import 'package:flutter/material.dart';

import '../content/item_details.dart';
import '../content/item_schedule.dart';
import '../content/item.dart';
import '../content/restaurant_foods.dart';
import '../controller/index.dart';

class RestaurantView extends StatelessWidget {
  final LocalModel local;
  RestaurantView(this.local);

  @override
  Widget build(BuildContext context) {
    if (local is! LocalModel) return Container();
    return WillPopScope(
      onWillPop: () async {
        await DialogService.doNotify;
        return false;
      },
      child: AppContainer(
        back: () async {
          await DialogService.doNotify;
        },
        bottomNavigation: BottomNavigation(
          onChange: HomeEvents.onSelectNav,
          type: BOTTOM_NAV.STACK,
        ),
        bottomText: "Detalle",
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            BuildItem(
              height: 280,
              local: local,
              type: IMG_DETAIL.RESTAURANT,
            ),
            SizedBox(height: 30),
            BuildFoods(local),
            BuildSchedule(
              phone: local.localPhone,
              url: local.urlInstagram,
              //initHour: local.openingTime,
              //endHour: local.endReopeningTime,
              initHour: local.doInitSchedule,
              endHour: local.endSchedule,
              isClosed: local.isClosed,
              address: local.address,
              latitude: local.latitude,
              longitude: local.longitude,
            ),
          ],
        ),
      ),
    );
  }
}
