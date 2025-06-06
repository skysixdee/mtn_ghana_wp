import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/faq_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';

Future<FaqModal> FaqApi() async {
  String url =
  faqUrl;
  //"https://callertunez.mtn.com.gh/crbt-web-portal/assets/languages/English/FAQ.json"; 

  Map<String, dynamic> jsonResp = await NetworkManager().get(url);
  return faqModalFromJson(json.encode(jsonResp));
}