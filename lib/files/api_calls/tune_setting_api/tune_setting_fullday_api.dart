import 'dart:math';

import 'package:mtn_ghana_wp/files/api_calls/tune_setting_api/tune_setting_dedicated_api.dart';
import 'package:mtn_ghana_wp/files/model/tune_setting_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<TuneSettingModel> fulldayApi(String days, String toneId) async {
  Random random = Random();
  var randomNumber = random.nextInt(1000000000);
  Map<String, dynamic> jsonData = {
    "clientTxnId": '$randomNumber',
    "aPartyMsisdn": StoreManager.msisdn,
    "toneId": toneId,
    "language": StoreManager.languageCode,
    "priority": "0",
    "channelId": channelId,
    "serviceId": "17",
    "activityId": "1",
    "timeType": "2",
    "weeklyDays": days,
    "weeklyStartTime": "00:00",
    "weeklyEndTime": "23:59",
  };
  return await _postApi(tuneSettingFulldayUrl, jsonData);
}

Future<TuneSettingModel> fulldayTimeBaseApi(
    String days, String toneId, DateTime fromD, DateTime toD) async {
  Random random = Random();
  var randomNumber = random.nextInt(1000000000);
  Map<String, dynamic> jsonData = {
    "clientTxnId": '$randomNumber',
    "aPartyMsisdn": StoreManager.msisdn,
    "toneId": toneId,
    "language": StoreManager.languageCode,
    "priority": "0",
    "channelId": channelId,
    "serviceId": "17",
    "activityId": "1",
    "timeType": "2",
    "weeklyDays": days,
    "weeklyStartTime": dateFormater(fromD, "HH:mm"),
    "weeklyEndTime": dateFormater(toD, "HH:mm"),
  };
  return await _postApi(tuneSettingFulldayUrl, jsonData);
}

Future<TuneSettingModel> fulldayRepeatBaseNoneApi(
    String toneId, DateTime fromD, DateTime toD) async {
  Random random = Random();
  var randomNumber = random.nextInt(1000000000);
  Map<String, dynamic> jsonData = {
    "clientTxnId": '$randomNumber',
    "aPartyMsisdn": StoreManager.msisdn,
    "toneId": toneId,
    "language": StoreManager.languageCode,
    "priority": "0",
    "channelId": channelId,
    "serviceId": "17",
    "activityId": "1",
    "timeType": "7",
    "customizeStartDate": dateFormater(fromD, "yyyy-MM-dd"),
    "customizeEndDate": dateFormater(toD, "yyyy-MM-dd"),
    "customizeStartTime": dateFormater(fromD, "HH:mm"),
    "customizeEndTime": dateFormater(toD, 'HH:mm'),
  };
  return await _postApi(tuneSettingFulldayUrl, jsonData);
}

Future<TuneSettingModel> fulldayRepeatBaseMonthlyApi(
    String toneId, DateTime fromD, DateTime toD) async {
  Random random = Random();
  var randomNumber = random.nextInt(1000000000);
  Map<String, dynamic> jsonData = {
    "clientTxnId": '$randomNumber',
    "aPartyMsisdn": StoreManager.msisdn,
    "toneId": toneId,
    "language": StoreManager.languageCode,
    "priority": "0",
    "channelId": channelId,
    "serviceId": "17",
    "activityId": "1",
    "timeType": "3",
    "startDayMonthly": dateFormater(fromD, "dd"),
    "endDayMonthly": dateFormater(toD, "dd"),
    "monthlyStartTime": dateFormater(fromD, "HH:mm"),
    "monthlyEndTime": dateFormater(toD, "HH:mm"),
  };
  return await _postApi(tuneSettingFulldayUrl, jsonData);
}

Future<TuneSettingModel> fulldayRepeatBaseYearlyApi(
    String toneId, DateTime fromTD, DateTime toTD) async {
  String yearlyStartMonth =
      dateFormater(fromTD, "MM"); //"${fromTD.month}".padLeft(2, "0");
  String yearlyEndMonth =
      dateFormater(toTD, 'MM'); //"${toTD.month}".padLeft(2, "0");

  String yearlyStartDay =
      dateFormater(fromTD, 'dd'); //"${fromTD.day}".padLeft(2, "0");

  String yearlyEndDay =
      dateFormater(toTD, "dd"); //"${toTD.day}".padLeft(2, "0");
  String yearlyStartTime = dateFormater(fromTD,
      'HH:mm'); // "${"${fromTD.hour}".padLeft(2, "0")}:${"${fromTD.minute}".padLeft(2, "0")}";
  String yearlyEndTime = dateFormater(toTD,
      'HH:mm'); //"${"${toTD.hour}".padLeft(2, "0")}:${"${toTD.minute}".padLeft(2, "0")}";

  Random random = Random();
  var randomNumber = random.nextInt(1000000000);
  Map<String, dynamic> jsonData = {
    "clientTxnId": '$randomNumber',
    "aPartyMsisdn": StoreManager.msisdn,
    "toneId": toneId,
    "language": StoreManager.languageCode,
    "priority": "0",
    "channelId": channelId,
    "serviceId": "17",
    "activityId": "1",
    "timeType": "4",
    "yearlyStartMonth": yearlyStartMonth, //02,
    "yearlyEndMonth": yearlyEndMonth,
    "yearlyStartDay": yearlyStartDay,
    "yearlyEndDay": yearlyEndDay,
    "yearlyStartTime": yearlyStartTime,
    "yearlyEndTime": yearlyEndTime,
  };
  return await _postApi(tuneSettingFulldayUrl, jsonData);
}

Future<TuneSettingModel> _postApi(
    String url, Map<String, dynamic> formData) async {
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(url, formData: formData);
  TuneSettingModel model = TuneSettingModel.fromJson(jsonResp);
  return model;
}
