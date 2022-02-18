import 'package:appclientes/service/auth/auth_service.dart';
import 'package:appclientes/service/navigation/constants/routes.dart';
import 'package:appclientes/service/navigation/controller/navigation_controller.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/components/app_navigation_bottom_bar/navigation_bottom_bar.dart';
import 'package:appclientes/v_cart/cart.dart';
import 'package:appclientes/v_center_notification/center_notifications.dart';
import 'package:appclientes/v_home/controller/index.dart';
import 'package:appclientes/v_home/home.dart';
import 'package:appclientes/v_profile/profile.dart';
import 'package:appclientes/v_order/order.dart';
import 'package:flutter/material.dart';

import '../../shared/components/app_safe_area/app_safe_area.dart';

class Dashboard extends StatefulWidget {
  final ROUTE_PAGE route;

  Dashboard([this.route]);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ROUTE_PAGE _page = ROUTE_PAGE.HOME;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      bottomNavigation:
          BottomNavigation(onChange: onChangePage, currentPage: _page),
      child: Column(
        children: [
          _buildPage,
        ],
      ),
    );
  }

  Expanded get _buildPage {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildWidget],
      ),
    );
  }

  Widget get _buildWidget {
    switch (_page) {
      case ROUTE_PAGE.HOME:
        return WillPopScope(
          onWillPop: doOpenLogin,
          child: HomeView(),
        );
        break;
      case ROUTE_PAGE.PROFILE:
        return WillPopScope(
          onWillPop: onBackAndroid,
          child: ProfileView(callback: backToHome),
        );
        break;
      case ROUTE_PAGE.ORDER:
        return WillPopScope(
          onWillPop: onBackAndroid,
          child: OrderView(callback: backToHome),
        );
        break;
      case ROUTE_PAGE.CART:
        return WillPopScope(
          onWillPop: onBackAndroid,
          child: BuyView(callback: backToHome),
        );
        break;
      default:
        return WillPopScope(
          onWillPop: onBackAndroid,
          child: Container(),
        );
    }
  }

  @override
  void initState() {
    if (widget.route is ROUTE_PAGE) _page = widget.route;
    super.initState();
    AuthRepository.addPushToken();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setDimensions();
  }

  void _setDimensions() {
    final appContext = MediaQuery.of(context);

    final newDimensions = Dimensions()
      ..topArea = appContext.padding.top
      ..bottomArea = appContext.padding.bottom
      ..height = appContext.size.height
      ..width = appContext.size.width;

    DimensionsState().update(newDimensions);
  }

  void onChangePage(ROUTE_PAGE page) {
    if (_page == ROUTE_PAGE.HOME) {
      HomeEvents.reload();
    }

    if (ROUTE_PAGE.HOME != page || HomeEvents.canNavigate) {
      /*if( page == ROUTE_PAGE.ORDER){
        OrderController.loadOrdersAfterClickOrder();
      }*/
      setState(() => _page = page);
    }
  }

  void backToHome() {
    if (HomeEvents.canNavigate) setState(() => _page = ROUTE_PAGE.HOME);
  }

  Future<bool> onBackAndroid() async {
    if (HomeEvents.canNavigate) goHome;
    return false;
  }

  void get goHome {
    setState(() => _page = ROUTE_PAGE.HOME);
  }

  Future<bool> doOpenLogin() async {
    NavController.doOpenLogin();
    return false;
  }
}
