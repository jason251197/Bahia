import 'package:appclientes/shared/common.dart';
import 'package:flutter/material.dart';

import 'content/account_details.dart';
import 'content/info_app.dart';

import '../v_localization/content/address_registered.dart';
import '../v_card/content/card_registered.dart';

class ProfileView extends StatelessWidget {
  final Function callback;
  const ProfileView({
    Key key,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppViews.common(
      text: "Mi Cuenta",
      back: callback,
      child: ListView(
        children: [
          AccountDetails(),
          AddressRegistered(),
          CardRegistered(),
          InfoApp(),
        ],
      ),
    );
  }
}
