import 'package:appclientes/service/logger/logger.dart';
import 'package:dio/dio.dart';

class IpService {
  static const _url = 'https://api.ipify.org';

  static void getPublicIp(Dio dio) async {
    try {
      var response = await dio.get(_url);
      if (response.statusCode == 200) {
        final ip = response.data;
        IpState().update(ip);
        Logger.log('public-ip-get', [ip]);
      }
    } catch (e) {
      Logger.err('public-ip', e);
    }
  }
}

class IpState {
  static IpState _instance;

  ///[_ipState] will manage the Request Events

  String _ipState;

  IpState._() {
    update('');
  }

  String get getValue => _ipState ?? '';

  void update(String data) => _ipState = data;

  void clean() {
    update('');
  }

  factory IpState() => _getInstance();

  //static IpState _getInstance() => _instance ?? IpState._();

  static IpState _getInstance() {
    if (_instance == null) {
      _instance = IpState._();
    }
    return _instance;
  }
}
