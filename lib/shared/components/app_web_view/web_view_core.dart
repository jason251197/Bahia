import 'dart:async';

import 'package:appclientes/service/device/device_service.dart';
import 'package:appclientes/service/ip/ip_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../../cache/cache.dart';
import '../../../service/logger/logger.dart';
import '../../helpers/cryptojs.dart';
import '../app_safe_area/app_safe_area.dart';
import '../app_view/app_view.dart';
import '../../../v_card/controller/index.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

class AppWebView extends StatefulWidget {
  /// Controls the web view
  final FlutterWebviewPlugin flutterWebviewPlugin;

  /// Url to be launched
  final String url;

  /// Wether to add JWT as a query param
  final bool useEncrypt;

  /// Stream to listen to when web view opens
  final Stream stream;

  /// Determines wether to close the web view
  final bool Function(dynamic) shouldClose;

  /// Function that runs when web view gets closed
  final Function onClose;
    
  final Function onMessage;  

  const AppWebView({
    Key key,
    @required this.flutterWebviewPlugin,
    @required this.url,
    @required this.useEncrypt,
    @required this.stream,
    @required this.shouldClose,
    @required this.onClose,
    @required this.onMessage,
  }) : super(key: key);

  @override
  _AppWebViewState createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  final dimensions = DimensionsState();

  /// Listens to the widget's stream
  StreamSubscription _streamSubscription;

  /// Listens to http errors
  StreamSubscription _onHttpError;

  @override
  Widget build(BuildContext context) {
    return AppViews.addCard(
      onBack: CardEvents.goBack,
      child: Column(
        children: [
          const Spacer(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setUp();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _onHttpError.cancel();
    super.dispose();
  }

  void setUp() {
    if (widget.useEncrypt && widget.url is String) {
      final key = SessionCache.getUser.publickey;
      final codeClient = SessionCache.getUser.code;
      final devideId = DeviceState().getValue;
      final ipPublica = IpState().getValue;
      final plainText = codeClient + "|" + devideId + "|" + ipPublica;
      final encryptedParam = encryptAESCryptoJS2(plainText, key);
      final url = widget.url + encryptedParam;
      // final url = widget.url +
      //     'U2FsdGVkX19jHMFX7kt69sewjWhUBBm8pfyhhyTXv0bonqwj2RDWCoNEOgrFvCcx';

      setupWebView(url);
    } else {
      setupWebView(widget.url);
    }
  }

  /// Launches url in web view if it's valid.
  /// Sets up listeners.
  void setupWebView(String url) {
    final topArea = dimensions.topArea;

    if (url.isNotEmpty) {
      print(url);
      print(topArea);
      print(dimensions.height);

      widget.flutterWebviewPlugin.close();
      widget.flutterWebviewPlugin.launch(
        url,
        rect: Rect.fromLTWH(0.0, (80 + topArea), dimensions.width,
            dimensions.height - (40 + topArea)),
        userAgent: kAndroidUserAgent,
      );

      log('REDIRECTING TO: $url');
      _streamSubscription = widget.stream.listen((event) {
        if (widget.shouldClose(event)) {
          log('CLOSING...');
          widget.flutterWebviewPlugin.close();
          widget.onClose();
          widget.onMessage(event);
        }
      });
      _onHttpError = widget.flutterWebviewPlugin.onHttpError
          .listen((WebViewHttpError error) {
        log(error.toString());
      });
    }
  }

  static const identity = 'InAppWebViewCore';
  static void log(dynamic value) => Logger.log(identity, [value]);
}
