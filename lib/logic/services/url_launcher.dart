import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  /// Class to acces [UrlLauncher]

  /// Launch URL
  static Future<void> launch(String uri) async {
    final url = Uri.parse(uri.toString());
    if (!await launchUrl(url)) {
      throw 'Could not launch ${uri.toString()}';
    }
  }
}
