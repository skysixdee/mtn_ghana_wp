import 'package:html_unescape/html_unescape.dart';

String decodeHtmlEntities(String encodedString) {
  final unescape = HtmlUnescape();
  return unescape.convert(encodedString);
}
