import 'package:etisalat/files/common/aes_enc_dec.dart';
import 'package:etisalat/files/common/rsa_encryption.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/get_transaction_id.dart';
import 'package:etisalat/files/utility/urls.dart';

passwordValidationApi(String msisdn, String securityCounter) async {
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
  Map<String, dynamic> jsonResp = await NetworkManager()
      .post(passwordValidateUrl, formData: jsonData, addInHeader: [
    {'languageId': StoreManager.languageCode}
  ]);
}
