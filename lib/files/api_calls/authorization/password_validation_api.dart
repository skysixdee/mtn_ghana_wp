import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/get_transaction_id.dart';
import 'package:etisalat/files/utility/urls.dart';

passwordValidationApi(
    String msisdn, String securityCounter, String encryptedPassword) async {
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
}
