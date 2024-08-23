import 'dart:convert';

import 'package:etisalat/files/model/security_token_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<SecurityTokenModel> getSecurityTokenApi() async {
  Map<String, dynamic> jsonResp = await NetworkManager().get(securityTokenUrl);
  return securityTokenModelFromJson(json.encode(jsonResp));
}
