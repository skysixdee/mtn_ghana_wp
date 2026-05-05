import 'package:mtn_ghana_wp/files/utility/urls.dart';

predictiveSongSearchApi(String query) async {
  String url =
      "$predictiveSearchUrl/selfcare/predictive/english-content-search/autocomplete/contentname?q=$query";
}
