library app_dialogs;

import 'package:appclientes/service/navigation/controller/navigation_controller.dart';
import 'package:appclientes/service/navigation/navigation_service.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/service/dialog/dialog_base.dart';
import 'package:appclientes/shared/constants/gifs.dart';
import 'package:appclientes/v_cart/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:appclientes/shared/constants/urls.dart';
import 'package:appclientes/service/launcher/launcher.dart';
import 'dart:io';

part './dialogs.dart';

class DialogService {
  static const loadingSize = 80.0;
  static Color opacity = Colors.black.withOpacity(0.5);

  static Future<void> onLoad(Future function) async {
    showLoading;
    await function;
    closeLoading;
  }

  static get showLoading => _buildDialogLoading(false);

  static get closeLoading {
    Navigator.pop(NavigationService().getContext);
  }

  static Future _buildDialogLoading(bool dissmisible) {
    return showDialog(
        context: NavigationService().getContext,
        barrierColor: opacity,
        barrierDismissible: dissmisible ?? true,
        builder: (_) => _buildLoadingIcon);
  }
  
  static void onLoading() {
    showDialog(
        context: NavigationService().getContext,
        barrierColor: opacity,
        barrierDismissible:false,
        builder: (_) => _buildLoadingIcon);
        new Future.delayed(new Duration(seconds: 1), () {
          Navigator.pop(NavigationService().getContext); //pop dialog
          //_login();
        });
  }

  static Widget get _buildLoadingIcon {
    return Center(child: AppIcon.path(AppGifs.loader, size: loadingSize * 0.9));
  }

  static get loadingWidget => SizedBox(
      height: loadingSize,
      width: loadingSize,
      child: CircularProgressIndicator());

  static Future get showRegistered async {
    await showDialogCard(Dialogs.simpleDialog("Te has registrado con éxito"));
  }

  static Future get showUserUpdated async {
    await showDialogCard(Dialogs.simpleDialog("Usuario Actualizado con éxito"));
  }

  static Future get closeAccount async {
    await showDialogCard(Dialogs.closeAccountDialog());
  }

  static Future get contactUs async {
    await showDialogCard(Dialogs.contactUsDialog());
  }

  static Future get _notify async =>
      await showDialogCard(Dialogs.closeOrders());

  static Future get doNotify async {
    if (CartState().getValue.isNotEmpty)
      await _notify;
    else
      NavigationService().pop();
  }

  static Future get cancelOrder async {
    await showDialogCard(Dialogs.cancelMyOrder());
  }

  static Future get showNotRegistered async {
    await showDialogCard(Dialogs.registerBeforeBuy());
  }

  static Future get showNotRegisteredProfile async {
    await showDialogCard(Dialogs.registerBeforeUpdate());
  }

  static Future showDeliveryDialog(String msg) async {
    await showDialogCard(Dialogs.confirmOrderDelivery(msg));
  }

  static Future showConfirmOrderDialog(String msg) async {
    await showDialogCard(Dialogs.confirmOrder(msg));
  }

  static Future showPickUpDialog(String msg) async {
    await showDialogCard(Dialogs.confirmOrderPickUp(msg));
  }

  static Future errorDialog(String msg) async {
    await showDialogCard(Dialogs.simpleDialog(msg));
  }

  static Future get localizationError async {
    await showDialogCard(await Dialogs.onMissingPermissions());
  }
  
  static Future get notAddAddressDialog async {
    await showDialogCard(await Dialogs.notAddAddressDialog());
  }

  static Future get adddressNotFound async {
    await showDialogCard(await Dialogs.addressNotFound());
  }

  static Future<bool> get deleteAddress async {
    return await showDialogCard(Dialogs.deleteAddress());
  }

  static Future get selectFoods async {
    await showDialogCard(Dialogs.selectProduct());
  }

  static Future<bool> get changeAddress async =>
      await showDialogCard(Dialogs.onChangeAddress());

  static Future get updateMe => showDialogCard(Dialogs.updateMe());

  static Future<bool> get logout async {
    return await showDialogCard(Dialogs.logout());
  }

  static Future yesNoDialog(String message) async =>
      await showDialogCard(Dialogs.yesNoDialog(message));

  static Future simpleDialog(String message) async {
    return await showDialog(
        context: NavigationService().getContext,
        barrierColor: opacity,
        barrierDismissible: true,
        builder: (_) => DialogBase(card: Dialogs.simpleDialog(message)));
  }

  static Future showDialogCard(DialogCard card) {
    return showDialog(
        context: NavigationService().getContext,
        barrierColor: opacity,
        barrierDismissible: true,
        builder: (_) => DialogBase(card: card));
  }

  static Future get validateProductStockMyOrder async =>
      showDialogCard(Dialogs.validateProductStockMyOrder());

  static Future get validateLocation async =>
      showDialogCard(Dialogs.validateLocation());

  static Future<bool> get deleteCard async {
    return await showDialogCard(Dialogs.deleteCard());
  }

  static Widget buildDialog(DialogCard card) => DialogBase(card: card);
  
  static Future cancelOrderDialog(String msg) async =>
    await showDialogCard(Dialogs.cancelOrder(msg));
}
