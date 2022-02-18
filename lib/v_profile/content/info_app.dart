import 'package:appclientes/service/navigation/navigation_service.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/v_center_notification/center_notifications.dart';
import 'package:appclientes/v_center_notification/controller/center_notification_controller.dart';
import 'package:appclientes/v_coupon/coupon.dart';
import 'package:appclientes/v_profile/data/profile_data.dart';
import 'package:appclientes/v_profile/content/info_arrow.dart';
import 'package:flutter/material.dart';

class InfoApp extends StatelessWidget {
  const InfoApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCard(
          title: "información sobre oliver",
          child: Column(
            children: [
              for (Map data in InfoData.infoAppData_1)
                InfoArrow(
                  icon: data['icon'],
                  title: data['title'],
                  onPress: data['onPress'],
                ),
            ],
          ),
        ),
        for (Map data in InfoData.infoAppData_2)
          EdgeInset.appPadding(
            vertical: 15.0,
            horizontal: 0.0,
            child: InfoArrow(
              icon: data['icon'],
              title: data['title'],
              onPress: data['onPress'],
              borderline: false,
              card: true,
            ),
          ),
        SimpleCard(
          child: Column(
            children: [
              InfoArrow(
                icon: Icons.notifications_active,
                title: "Centro de notificaciones",
                onPress: () {
                  NavigationService()
                      .navigateTo(screen: CenterNotificationView());
                },
              ),
              InfoArrow(
                icon: Icons.money_rounded,
                title: "Cupones",
                onPress: () {
                  NavigationService().navigateTo(screen: CouponView());
                },
              ),
            ],
          ),
        ),
        SimpleCard(
          child: Column(
            children: [
              for (Map data in InfoData.infoAppData_3)
                InfoArrow(
                  icon: data['icon'],
                  title: data['title'],
                  onPress: data['onPress'],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
