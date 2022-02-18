import 'package:appclientes/cache/cache.dart';
import 'package:appclientes/service/api/api_service.dart';
import 'package:appclientes/service/device/device_service.dart';
import 'package:appclientes/service/ip/ip_service.dart';
import 'package:appclientes/service/notification/notification_service.dart';
import 'package:appclientes/service/sentry/sentry_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BootService {
  static Future<void> get initializeServices async {
    WidgetsFlutterBinding.ensureInitialized();
    SentryService().initFlutterError;
    cache = await SharedPreferences.getInstance();
    dio = Dio(RootApi.root);
    IpService.getPublicIp(dio);
    DeviceService.loadDeviceUUID;
    await NotificationService.initializeApp();

    /// [FILL SERVICES HERE]
  }
}
