import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:appclientes/cache/cache.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static StreamController<String> _messageStream =
      new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static FlutterLocalNotificationsPlugin fltNotification =
      FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true,
  );

  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    await requestPermission();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await fltNotification.initialize(initializationSettings,
        onSelectNotification: _onMessageLocalOpenApp);
  }

  static Future _backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    Future.delayed(Duration(microseconds: 100), () {
      RemoteNotification notification = message.notification;
      fltNotification.show(
          (new Random()).nextInt(10000),
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: json.encode(message.data));
    });
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    _messageStream.add(message.data["tipo"]);
  }

  static Future _onMessageLocalOpenApp(String message) async {
    Map valueMap = json.decode(message);
    _messageStream.add(valueMap["tipo"]);
  }

  static Future<String> getToken() async {
    try {
      String token = await FirebaseMessaging.instance.getToken();
      await SessionCache.setPushToken(token);
      return token;
    } catch (e) {
      return null;
    }
  }

  static void removeToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }

  static requestPermission() async {
    await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
  }

  static closeStreams() {
    _messageStream.close();
  }
}
