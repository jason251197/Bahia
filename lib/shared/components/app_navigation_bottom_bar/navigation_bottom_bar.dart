import 'package:appclientes/service/navigation/constants/routes.dart';
import 'package:appclientes/service/navigation/controller/navigation_controller.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/components/app_safe_area/app_safe_area.dart';
import 'package:appclientes/v_cart/content/build_events.dart';
import 'package:appclientes/v_cart/controller/index.dart';
import 'package:flutter/material.dart';

List<int> _buttonList = List<int>.generate(ROUTE_PAGE.values.length, (index) => index);

enum BOTTOM_NAV { STACK, REG }

class BottomNavigation extends StatelessWidget {
  final Function(ROUTE_PAGE) onChange;
  final ROUTE_PAGE currentPage;
  final BOTTOM_NAV type;
  const BottomNavigation({
    Key key,
    this.onChange,
    this.currentPage,
    this.type = BOTTOM_NAV.REG,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSafeArea(
      child: Container(
        height: 55,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            for (int button in _buttonList) _buildNavButton(button),
          ],
        ),
      ),
    );
  }

  Flexible _buildNavButton(button) {
    return Flexible(
      child: FlatButton(
        color: _tabColor(button),
        onPressed: () => onTabTapped(button),
        child: Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              button == 0
                  ? AppIcon.path(
                      AppIcon.home,
                      color: _iconColor(button),
                    )
                  : Padding(
                      padding: button == 1
                          ? const EdgeInsets.all(8)
                          : EdgeInsets.zero,
                      child: Icon(
                        _buildIcon(button),
                        color: _iconColor(button),
                      ),
                    ),
              if (button == 1) _buildBudgetCounter
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildBudgetCounter {
    return CartRender(child: () {
      final counter = CartState().totalItems;
      if (counter == 0) return SizedBox();
      return Positioned(
        right: 0,
        top: 0,
        child: ClipOval(
          child: Container(
            color: Colors.red,
            height: 17,
            width: 17,
            alignment: Alignment.center,
            child: Texts.whiteBold("$counter", fontSize: 10),
          ),
        ),
      );
    });
  }

  IconData _buildIcon(index) {
    switch (index) {
      case 1:
        return Icons.shopping_cart;
        break;
      case 2:
        return Icons.description_outlined;
        break;
      case 3:
        return Icons.person;
        break;
      default:
        return Icons.close;
    }
  }

  void onTabTapped(int index) {
    if ((index != 2 && index != 3) || NavController.doOpenLogin()) {
      if (onChange is Function) onChange(ROUTE_PAGE.values[index]);
    }
  }

  Color _iconColor(int index) {
    return ROUTE_PAGE.values[index] == valueToCompare
        ? Colors.white
        : AppColors.black;
  }

  Color _tabColor(int index) {
    return ROUTE_PAGE.values[index] == valueToCompare
        ? AppColors.black
        : AppColors.yellow;
  }

  get valueToCompare =>
      type == BOTTOM_NAV.STACK ? ROUTE_PAGE.HOME : currentPage;
}
