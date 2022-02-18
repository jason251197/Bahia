import 'package:appclientes/cache/cache.dart';
import 'package:appclientes/shared/components/app_bar/controller/app_bar_controller.dart';
import 'package:flutter/material.dart';

import '../../common.dart';
import '../app_safe_area/app_safe_area.dart';
import '../../components/app_gray_top_header/gray_top_header.dart';
import 'controller/app_bar_state.dart';

class AppTopBar extends StatelessWidget {
  final String text;
  final String bottomText;
  final Function back;
  final Widget body;
  final bool blockRedirect;
  const AppTopBar({
    Key key,
    this.text,
    this.back,
    this.body,
    this.bottomText,
    this.blockRedirect = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TopSafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: blockRedirect ? null : AppBarController.redirecToAddress,
              child: Container(
                height: 40,
                color: AppColors.yellow,
                child: BuilderAddress(text: text),
              ),
            ),
            if (body is Widget || bottomText is String)
              GrayTopHeader(back: back, child: body, text: bottomText),
          ],
        ),
      ),
    );
  }
}

class BuilderAddress extends StatefulWidget {
  final String text;
  const BuilderAddress({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  _BuilderAddressState createState() => _BuilderAddressState();
}

class _BuilderAddressState extends State<BuilderAddress> {
  @override
  void initState() {
    AddressState().update(AddressCache?.getCurrentAddress ?? null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AddressState().getEvents,
      builder: (context, snapshot) {
        String address = AddressState().getAddress;
        return Center(
          child:
              Texts.black(widget.text ?? address, textAlign: TextAlign.center),
        );
      },
    );
  }
}
