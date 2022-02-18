import 'package:appclientes/packages/address_card/address_card.dart';
import 'package:appclientes/service/navigation/controller/navigation_controller.dart';
import 'package:appclientes/shared/common.dart';
import 'controller/localization_controller.dart';
import 'package:flutter/material.dart';

class LocalizationView extends StatelessWidget {
  final bool addAddress;
  final bool canPop;
  final AddressModel address;
  final bool blockRedirectAddress;

  LocalizationView(
      {this.addAddress = false,
      this.canPop = false,
      this.address,
      this.blockRedirectAddress = false});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: doOpenLogin,
      child: AppViews.localitation(
        onBack: addAddress || address is AddressModel
            ? LocalizationController.goBack
            : null,
        block: blockRedirectAddress,
        child: Column(
          children: [
            Expanded(
              child: AddressCard(
                addAddress: addAddress,
                loadAddress: address,
                onDone: (BuildContext _, AddressModel _address) async {
                  if (addAddress)
                    LocalizationController.saveAddress(_address, doPop: true);
                  else if (address is AddressModel)
                    Navigator.pop(
                        context,
                        await LocalizationController.updateCacheAddress(
                            _address));
                  else
                    LocalizationController.saveAddress(_address);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> doOpenLogin() async {
    if (canPop) NavController.popToLogin();
    return false;
  }
}
