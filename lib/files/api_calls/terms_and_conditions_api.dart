import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/terms_and_conditions_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';

Future<TermsAndConditionsModel> termsAndConditionsApi() async {
    final String apiUrl = termsAndConditionUrl;//'https://crbt.mtn.co.sz/crbt-portal/assets/languages/English/TandQ.json';
    
     Map<String, dynamic> jsonResp = await NetworkManager().get(apiUrl);
     return termsAndConditionsModelFromJson(json.encode(jsonResp));
   
  }

  
