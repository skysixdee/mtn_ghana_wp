import 'package:mtn_ghana_wp/files/api_calls/authorization/password_validation_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/authorization/security_token_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/authorization/subscriber_validation_api.dart';
import 'package:mtn_ghana_wp/files/model/password_validation_model.dart';
import 'package:mtn_ghana_wp/files/model/security_token_model.dart';
import 'package:mtn_ghana_wp/files/model/subscriber_validation_model.dart';

autoLoginApi(String msisdn) async {
  SubscriberValidationModel subscriberValidationModel =
      await susbcriberValidationApi(msisdn);
  if (subscriberValidationModel.statusCode == 'SC0000') {
    SecurityTokenModel tokenModel = await getSecurityTokenApi();
    if (tokenModel.statusCode == 'SC0000') {
      PasswordValidationModel model = await passwordValidationApi(
          msisdn, tokenModel.responseMap?.securityCounter ?? '');
    }
  }
}
