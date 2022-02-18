import 'package:appclientes/service/services.dart';
import 'package:appclientes/shared/constants/urls.dart';
import 'package:sentry/sentry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SentryService {
  static SentryService _instance;

  SentryClient _sentryClient;

  SentryService._() {
    _sentryClient = SentryClient(
      dsn: AppURLs.sentryURL,
      environmentAttributes: Event(
        message: "LOG",
        level: SeverityLevel.info,
        tags: {"USAGE": "TEST-LOGS"},
      ),
    );
  }

  /// [log-temp] SENDS THE LOGS TO SENTRY SERVICE
  Future<SentryResponse> sendInfoLog(dynamic log) async => kReleaseMode
      ? await _sentryClient.captureException(
          exception: log, stackTrace: StackTrace.current)
      : null;

  /// [log] SENDS THE LOGS TO SENTRY SERVICE
  Future<SentryResponse> sendLog(String event, Map<String, dynamic> log,
          [SeverityLevel level = SeverityLevel.warning,
          Map<String, dynamic> tags]) async =>
      _sentryClient.capture(
          event: Event(
        message: event,
        level: level,
        extra: log,
        tags: tags ?? {"USAGE": event},
        stackTrace: StackTrace.current,
      ));

  /// [initFlutterError] SENDS FLUTTER ERROR TO SENTRY SERVICE
  get initFlutterError {
    if (kReleaseMode)
      FlutterError.onError = (FlutterErrorDetails error) {
        _sentryClient.captureException(
          exception: error,
          stackTrace: error.stack,
        );
      };
  }

  void initPrefs(UserModel user) =>
      _sentryClient.userContext = user?.toSentryUserModel;

  void get cleanPrefs => _sentryClient.userContext = null;

  factory SentryService() => _getInstance();

  static SentryService _getInstance() {
    if (_instance == null) {
      _instance = SentryService._();
    }
    return _instance;
  }
}
