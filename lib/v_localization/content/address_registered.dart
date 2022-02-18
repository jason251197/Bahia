import 'dart:async';

import 'package:appclientes/cache/cache.dart';
import 'package:appclientes/packages/address_card/address_card.dart';
import 'package:appclientes/service/api/api_service.dart';
import 'package:appclientes/service/services.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/components/app_bar/controller/app_bar_state.dart';
import 'package:appclientes/v_cart/controller/index.dart';
import 'package:appclientes/v_localization/controller/localization_controller.dart';
import 'package:appclientes/v_localization/controller/models/address_list.dart';
import 'package:flutter/material.dart';

import '../view/content/../../content/build_direction.dart';

class AddressRegistered extends StatefulWidget {
  final bool useView;
  const AddressRegistered({
    Key key,
    this.useView = false,
  }) : super(key: key);

  @override
  _AddressRegisteredState createState() => _AddressRegisteredState();
}

class _AddressRegisteredState extends State<AddressRegistered> {
  AddressList addressList;
  AddressModel _addressSelected;
  StreamSubscription streamSubscription;

  @override
  void initState() {
    buildAddresses;
    streamSubscription = AddressState().onUpdateEvents.listen(onEventUpdate);
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useView) return _buildDirections;
    return AppCard(
      title: "direcciones registradas",
      child: _buildDirections,
    );
  }

  Column get _buildDirections {
    return Column(
      children: [
        if (addressList?.addresses is List)
          ...addressList.addresses.asMap().entries.map(
                (e) => BuildDirection(
                  address: e.value,
                  index: e.key,
                  selected: _addressSelected,
                  onPress: _onAddressChange,
                  onLongPress: _openSelectedAddress,
                  onDelete: (AddressModel v) =>
                      LocalizationController.deleteAddres(v)
                          .then((_) => _ ? AddressState().rebuild : null),
                ),
              ),
        SaveTag(
          'agregar dirección',
          onPress: () async {
            if (await AppConnectivity.check())
              LocalizationController.goToAddAddress()
                  .then((_) => AddressState().rebuild);
          },
        ),
      ],
    );
  }

  void _onAddressChange(AddressModel current) async {
    if (await AppConnectivity.check()) {
      if (AddressCache.getCurrentAddress?.code != current.code) {
        bool doRedirect = true;

        if (!CartEvents.isCartEmpty())
          doRedirect = await DialogService.changeAddress;

        if (doRedirect) {
          await AddressCache.setSelectedAddress(current);
          LocalizationController.updateSelectedAddressAndLoad(current);
        }
      }
    }
  }

  void _openSelectedAddress(AddressModel current) async {
    if (await AppConnectivity.check())
      await LocalizationController.openAddress(current)
          .then((_) => _ ? rebuild : null);
  }

  void get rebuild {
    setState(() => buildAddresses);
  }

  void get buildAddresses {
    _addressSelected = AddressCache?.getCurrentAddress;
    AddressState().update(_addressSelected);
    addressList = LocalizationController.loadAddresses;
  }

  void onEventUpdate(event) => event is bool ? rebuild : null;
}
