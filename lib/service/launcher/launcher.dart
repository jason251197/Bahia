import 'package:appclientes/service/logger/logger.dart';
import 'package:appclientes/service/services.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherService {

  static void launchWeb(String url) async {
    if(await AppConnectivity.check()) {
      if (await canLaunch(url)) {
        Logger.log("LAUNCHING-URL-WEB", [url]);
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
        );
      } else
        throw 'Could not launch $url';
    }
  }

  static void launchWebView(String url) async {
    if(await AppConnectivity.check()) {
      if (await canLaunch(url)) {
        Logger.log("LAUNCHING-URL-WEB-VIEW", [url]);
        await launch(
          url,
          forceSafariVC: true,
          forceWebView: true,
          enableJavaScript: true,
        );
      } else
        throw 'Could not launch $url';
    }
  }

  static void launchEmail() async {
    final _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'smith@example.com',
        queryParameters: {'subject': 'Example Subject & Symbols are allowed!'});

    final url = _emailLaunchUri.toString();
    if (await canLaunch(url)) {
      Logger.log("LAUNCHING-EMAIL", [url]);
      await launch(url);
    } else
      throw 'Could not launch $url';
  }

  static void launchPhone(String phone) async {
    final url = "tel:$phone";
    if (await canLaunch(url)) {
      Logger.log("LAUNCHING-PHONE", [url]);
      await launch(url);
    } else
      throw 'Could not launch $url';
  }
  
  static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
