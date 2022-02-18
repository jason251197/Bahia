import 'package:appclientes/shared/common.dart';
import '../content/address_registered.dart';

import 'package:flutter/material.dart';

class AddressRegisteredView extends StatelessWidget {
  final Function callback;
  AddressRegisteredView({this.callback});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      back: () => Navigator.pop(context),
      bottomText: "Mis Direcciones",
      child: EdgeInset.appPadding(
        horizontal: 10.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 10),
            AddressRegistered(
              useView: true,
              // key: UniqueKey(),
            )
          ],
        ),
      ),
    );
  }
}
