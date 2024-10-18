import 'package:url_launcher/url_launcher.dart';

Future<void> customLaunchUrl(String url, {bool inNewWindow = true}) async {
  final Uri url0 = Uri.parse(url);
  if (!await launchUrl(url0, webOnlyWindowName: inNewWindow ? '' : '_self')) {
    throw Exception('Could not launch $url0');
  }
}
