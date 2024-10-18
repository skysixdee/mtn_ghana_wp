import 'dart:convert';

import 'package:mtn_ghana_wp/files/common/rsa_encryption.dart';
import 'package:mtn_ghana_wp/files/google_tag_manager/google_tag_manager.dart';
import 'package:mtn_ghana_wp/files/model/password_validation_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<PasswordValidationModel> passwordValidationApi(
    String msisdn, String securityCounter) async {
  var pass = 'Oem@L#@1';
  var password = "$pass$securityCounter";
  print("password is here $password");
  String encryptedPassword = rsaEncryption(password); //aesEncryption(password);
  Map<String, dynamic> jsonData = {
    "type": "ValidateDetails",
    "msisdn": msisdn,
    "languageId": StoreManager.languageCode,
    "clientTxnId": getTransactionId(),
    "securityCounter": securityCounter,
    "encryptedPassword": encryptedPassword,
    "versionCode": versionCode,
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(passwordValidateUrl, formData: jsonData);
  PasswordValidationModel passwordValidationModel =
      PasswordValidationModel.fromJson(jsonResp);
  if (passwordValidationModel.statusCode == 'SC0000') {
    loginSuccessfulEvent(msisdn);
    ResponseMap? info = passwordValidationModel.responseMap;
    StoreManager.setAccessToken(info?.accessToken ?? '');
    StoreManager.setDeviceId(info?.deviceId ?? '');
    StoreManager.setRefreshToken(info?.refreshToken ?? '');
    StoreManager.setMsisdn(msisdn);
    StoreManager.setLoggedIn(true);
    loginSuccessfulEvent(msisdn);
    homePageHeFootPrintEvent(msisdn);
  }
  return passwordValidationModel;
}
