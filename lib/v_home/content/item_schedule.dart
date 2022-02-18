import 'package:appclientes/service/launcher/launcher.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/constants/urls.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'tag_gray.dart';
import 'tag_blue.dart';

class BuildSchedule extends StatelessWidget {
  final String url;
  final String phone;
  final String initHour;
  final String endHour;
  final bool isClosed;
  final String address;
  final num latitude;
  final num longitude;
  const BuildSchedule({
    Key key,
    this.url,
    this.phone,
    this.initHour,
    this.endHour,
    this.isClosed,
    this.address,
    this.latitude,
    this.longitude
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInset.vertical((endHour.isEmpty && initHour.isEmpty) ? 0.0 : 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.symmetric(
          vertical: BorderSide(color: AppColors.graySoft1, width: 1),
        ),
      ),
      child: Column(
        children: [
          EdgeInset.appPadding(
            vertical: (endHour.isEmpty && initHour.isEmpty) ? 0.0 : 10.0,
            child: (endHour.isEmpty && initHour.isEmpty) ? Texts.black("")
                : (endHour.isEmpty || initHour.isEmpty) ? Texts.black("Horario de apertura", fontSize: 15)
                : Texts.black("Horario de apertura y reapertura del Local",
                    fontSize: 15),
          ),
          EdgeInset.appPadding(
            vertical: (endHour.isEmpty && initHour.isEmpty) ? 0.0 : 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (initHour is String && initHour.length>0)  GrayTag(initHour ?? ''),
                if (endHour is String && endHour.isNotEmpty && initHour.length>0)
                  SizedBox(width: 15),
                if (endHour is String && endHour.isNotEmpty)
                  GrayTag(endHour ?? ''),
              ],
            ),
          ),
          EdgeInset.appPadding(
            vertical: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () =>
                        url is String ? LauncherService.launchWeb(url) : null,
                    icon: AppIcon.path(AppIcon.instagram,
                        width: 30.0, height: 30.0)),
                SizedBox(width: 15),
                IconButton(
                    onPressed: () => phone is String
                        ? LauncherService.launchPhone(phone)
                        : null,
                    icon: AppIcon.path(AppIcon.phone2,
                        width: 30.0, height: 30.0)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 0,top: 8.0, bottom: 10),
            child: Column(
              children: [
                RichText(
                    softWrap: true,
                    textAlign: TextAlign.center,
                    text: TextSpan(style: TextStyle(color: AppColors.blue, fontFamily: FontFamily.REGULAR_ASSISTANT,),
                      children: [
                        TextSpan(
                            text: address,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                LauncherService.launchURL(AppURLs.mapsMarket+latitude.toString()+','+longitude.toString());
                              }
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
          if (isClosed)
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: BlueTag("Cerrado"),
          ),
        ],
      ),
    );
  }
}
