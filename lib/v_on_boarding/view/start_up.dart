import 'package:appclientes/packages/address_card/address_card.dart';
import 'package:appclientes/shared/common.dart';
import 'package:flutter/material.dart';
import '../controller/on_boarding_controller.dart';
import 'package:location/location.dart';

class StartUpView extends StatefulWidget {
  @override
  _StartUpViewState createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  @override
  void initState() {
    super.initState();
    //_initLocalization();
  }

  // void _initLocalization() async {
  //   await Future.delayed(Duration(milliseconds: 500), () {
  //     LocationService.initLocationService();
  //   });
  // }

  static redirectToMaps() async {
    //if (await LocationService.initLocationService() == PermissionStatus.granted)//comentado por APPSTORE
      OnBoardingController.redirectToMaps();
  }

  @override
  Widget build(BuildContext context) {
    return AppView(
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.elliptical(260, 70)),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.yellow,
                  image: DecorationImage(
                    image: AssetImage(AppImages.LOGO_3),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Buttons.yellow(
                  "EMPIEZA",
                  width: 150,
                  onClick:
                      redirectToMaps, //OnBoardingController.redirectToMaps,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
