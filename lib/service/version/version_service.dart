import 'dart:io';

import 'package:appclientes/service/api/api_service.dart';
import 'package:appclientes/service/dialog/dialog_service.dart';
import 'package:package_info/package_info.dart';

class VersionService {
  static Future<bool> check() async {
    bool mustUpdate = false;
    final version = await getAppVersion();

    if (version is String) {
      String platform;
      if (Platform.isAndroid) {
        platform = 'ANDROID';
      } else if (Platform.isIOS) {
        platform = 'IOS';
      }
      final _body = {
        "entity": {"version": version ?? '', "device": platform}
      };
      await ApiService.fetch(
        Apis.checkVersion(_body),
        showSuccessDialog: false,
        onSuccess: (res) {
          try {
            mustUpdate = res.data['result']['status'] == false ||
                res.data['entity']['data']['newVersion'] == true;
          } catch (_) {
            mustUpdate = false;
          }
        },
      );
      return mustUpdate;
    }
    return false;
  }

  static Future<String> getAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();

      return packageInfo.version + '+' + packageInfo.buildNumber;
    } catch (_) {}

    return null;
  }

  static Future<bool> initAppVersionCheck() async {
    final version = await VersionService.check();

    if (version is bool && version) {
      DialogService.updateMe;
    }
    return version;
  }
}
