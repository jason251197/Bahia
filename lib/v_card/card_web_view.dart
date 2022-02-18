import 'dart:async';

import 'package:appclientes/cache/cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../service/services.dart';
import '../shared/components/app_web_view/web_view_core.dart';
import '../shared/constants/urls.dart';
import '../v_card/controller/index.dart';

class AddCardWebView extends StatefulWidget {
  const AddCardWebView({Key key}) : super(key: key);

  @override
  _AddCardWebViewState createState() => _AddCardWebViewState();
}

class _AddCardWebViewState extends State<AddCardWebView> {
  // Instance of WebView plugin
  final _flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    return AppWebView(
      flutterWebviewPlugin: _flutterWebViewPlugin,
      url: AppURLs.newCard,
      stream: _flutterWebViewPlugin.onUrlChanged,
      shouldClose: _shouldClose,
      onClose: _updateCards,
      onMessage: _MessageCards,
      useEncrypt: true,
    );
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _flutterWebViewPlugin.close();
    _flutterWebViewPlugin.dispose();
    super.dispose();
  }

  /// CLOSES WEB VIEW ON CERTAIN URL CHANGES
  /*
  bool _shouldClose(dynamic event) {
    final url = event as String;
    return url == AppURLs.onCreateSuccessCard;
  }
  */
  bool _shouldClose(dynamic event) {
    final url = event as String;
    if (url == AppURLs.onCreateSuccessCard){
      return true;
    }else if (url == AppURLs.onCreateFailCard){
      return true;
    }
    return false;
  }

  void _MessageCards(dynamic event) async {
    final url = event as String;
    if (url == AppURLs.onCreateSuccessCard){
        await DialogService.simpleDialog("Operación realizada con éxito");
        if(await _updateCards2()){
          if (mounted) Navigator.pop(context);
        }
    }else if (url == AppURLs.onCreateFailCard){
      await DialogService.simpleDialog("Error, Operación sin éxito");
      if (mounted) Navigator.pop(context);
    }
  }

  void _updateCards() async {
  }
  
  Future<bool> _updateCards2() async {
    final codClient = SessionService.getCodClient;
    final cards = await CardRepository.getUserCards2(codClient, false);
    CardCache.setCardList(cards);
    //if (mounted) Navigator.pop(context);
    return true;
  }
  
  /*
  void _updateCards() => Future.delayed(const Duration(seconds: 1), () async {
        final codClient = SessionService.getCodClient;
        final cards = await CardRepository.getUserCards(codClient, false);
        CardCache.setCardList(cards);
        //if (mounted) Navigator.pop(context);
      });
      */
}
