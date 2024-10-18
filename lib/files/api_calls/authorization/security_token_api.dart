import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/security_token_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<SecurityTokenModel> getSecurityTokenApi() async {
  Map<String, dynamic> jsonResp = await NetworkManager().get(securityTokenUrl);
  return securityTokenModelFromJson(json.encode(jsonResp));
}
