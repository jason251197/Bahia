import 'dart:io';

import 'package:appclientes/service/logger/logger.dart';
import 'package:device_info/device_info.dart';

class DeviceService {
  static Future<String> get loadDeviceUUID async {
    String identifier;
    final deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        final build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
      }
      if (Platform.isIOS) {
        final data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }

      Logger.log('devide-info-get', [identifier]);
    } catch (err) {
      Logger.err('devide-info', err);
    }

    DeviceState().update(identifier);

    return identifier;
  }
}

class DeviceState {
  static DeviceState _instance;

  ///[_deviceUUID] will manage the Request Events

  String _deviceUUID;

  DeviceState._() {
    update('');
  }

  String get getValue => _deviceUUID ?? '';

  void update(String data) => _deviceUUID = data;

  void clean() {
    update('');
  }

  factory DeviceState() => _getInstance();

  //static DeviceState _getInstance() => _instance ?? DeviceState._();

  static DeviceState _getInstance() {
    if (_instance == null) {
      _instance = DeviceState._();
    }
    return _instance;
  }
}
