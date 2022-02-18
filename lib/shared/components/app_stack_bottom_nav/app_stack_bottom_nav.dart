import 'package:appclientes/service/navigation/constants/routes.dart';
import 'package:appclientes/shared/components/app_navigation_bottom_bar/navigation_bottom_bar.dart';

import 'package:flutter/material.dart';

class StackBottomNav extends StatelessWidget {
  final Function(ROUTE_PAGE) onChange;
  final Widget body;
  const StackBottomNav(
    this.body, {
    Key key,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body ?? Container(),
      bottomNavigationBar: BottomNavigation(
        onChange: onChange,
        type: BOTTOM_NAV.STACK,
      ),
    );
  }
}
