import 'package:mtn_ghana_wp/files/utility/urls.dart';

predictiveArtistSearchApi(String query) async {
  final encodedQuery = Uri.encodeQueryComponent(query);
  String url =
      "$predictiveSearchUrl/selfcare/predictive/english-artist-search/autocomplete/artist?q=$encodedQuery";
}
