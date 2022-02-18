import 'package:appclientes/service/sentry/sentry_service.dart';
import 'package:flutter/foundation.dart';

class Logger {
  static void err(String identity, err, [stack]) {
    if (!kReleaseMode)
      print("ERR  ::: ${identity.toUpperCase()} ::: \n$err\nLOGGER::\n$stack");
  }

  static void log(String identity, List<dynamic> log,
      {bool useSentry = false}) {
    if (kReleaseMode && useSentry) SentryService().sendLog(identity, log.first);

    if (!kReleaseMode)
      print("LOG [${identity.toUpperCase()}] : ${log.join(",\n-> ")}");
  }
}
