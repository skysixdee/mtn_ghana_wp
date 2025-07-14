import 'dart:math';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_setting_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Future<GenericModel> fulldayDedicatedApi(
    String toneId, String bParty, String packName, String days) async {
  Random random = Random();
  var randomNumber = random.nextInt(1000000000);

  Map<String, dynamic> jsonData = {
    // "clientTxnId": '$randomNumber',
    // "aPartyMsisdn": StoreManager.msisdn,
    // "toneId": toneId,
    // "language": StoreManager.languageCode,
    // "priority": "0",
    // "channelId": channelId,
    // "bPartyMsisdn": bParty,
    // "serviceId": "13",
    // "activityId": "1",
    // "packName": packName,
    // "timeType": "2",
    // "weeklyDays": days.isEmpty ? "0" : days,
    // "weeklyStartTime": "00:00",
    // "weeklyEndTime": "23:59",
    "transactionId": getTransactionId(),
    "featureId": 1,
    "msisdn": StoreManager.msisdn,
    "bmsisdn": bParty,
    "offerCode": packName,
    "contentId": toneId,
    "languageCode": StoreManager.languageSort,
    "channelId": channelId,
  };

  //String url, Map<String, dynamic> formData) async {
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(tuneSettingDedicatedUrl, jsonData: jsonData);
  GenericModel model = GenericModel.fromJson(jsonResp);

  return model; //await _postApi(tuneSettingDedicatedUrl, jsonData);
}

Future<TuneSettingModel> fulldayTimeBaseDedicatedApi(
    String toneId,
    String bParty,
    String packName,
    String days,
    DateTime fromT,
    DateTime toT) async {
  Random random = Random();
  var randomNumber = random.nextInt(1000000000);

  Map<String, dynamic> jsonData = {
    "clientTxnId": '$randomNumber',
    "aPartyMsisdn": StoreManager.msisdn,
    "toneId": toneId,
    "language": StoreManager.languageCode,
    "priority": "0",
    "channelId": channelId,
    "bPartyMsisdn": bParty,
    "serviceId": "13",
    "activityId": "1",
    "packName": packName,
    "timeType": "2",
    "weeklyDays": days.isEmpty ? "0" : days,
    "weeklyStartTime": dateFormater(fromT, 'hh:mm'), //fromT12,
    "weeklyEndTime": dateFormater(toT, 'hh:mm'),
  };
  return await _postApi(tuneSettingDedicatedUrl, jsonData);
}

Future<TuneSettingModel> fulldayRepeatBaseNoneDedicatedApi(String toneId,
    String bParty, String packName, DateTime fromTD, DateTime toTD) async {
  Random random = Random();
  var randomNumber = random.nextInt(1000000000);

  String fm = "${fromTD.month}".padLeft(2, '0');
  String fd = "${fromTD.day}".padLeft(2, '0');

  String tm = "${toTD.month}".padLeft(2, '0');
  String td = "${toTD.day}".padLeft(2, '0');

  String fth = "${fromTD.hour}".padLeft(2, '0');
  String ftm = "${fromTD.minute}".padLeft(2, '0');

  String tth = "${toTD.hour}".padLeft(2, '0');
  String ttm = "${toTD.minute}".padLeft(2, '0');

  String customizeStartDate = "${fromTD.year}-$fm-$fd"; //": 2024-02-28
  String customizeEndDate = "${toTD.year}-$tm-$td"; //": 2024-02-29
  String customizeStartTime = "$fth:$ftm"; //": 10:03
  String customizeEndTime = "$tth:$ttm"; //": 11:27

  Map<String, dynamic> jsonData = {
    "clientTxnId": '$randomNumber',
    "aPartyMsisdn": StoreManager.msisdn,
    "toneId": toneId,
    "language": StoreManager.languageCode,
    "priority": "0",
    "channelId": channelId,
    "bPartyMsisdn": bParty,
    "serviceId": "13",
    "activityId": "1",
    "packName": packName,
    "timeType": "7",
    "customizeStartDate": customizeStartDate,
    "customizeEndDate": customizeEndDate,
    "customizeStartTime": customizeStartTime,
    "customizeEndTime": customizeEndTime
  };
  return await _postApi(tuneSettingDedicatedUrl, jsonData);
}

Future<TuneSettingModel> fulldayRepeatBaseMonthlyDedicatedApi(String toneId,
    String bParty, String packName, DateTime fromTD, DateTime toTD) async {
  Random random = Random();
  var randomNumber = random.nextInt(1000000000);

  String startDayMonthly =
      dateFormater(fromTD, "dd"); //"${fromTD.day}".padLeft(2, '0'); //": 28
  String endDayMonthly =
      dateFormater(toTD, 'MM'); //"${toTD.day}".padLeft(2, '0'); //": 29
  String monthlyStartTime = dateFormater(fromTD, 'hh:mm');
  //"${"${fromTD.hour}".padLeft(2, '0')}:${"${fromTD.minute}".padLeft(2, '0')}"; //": 10:04
  String monthlyEndTime = dateFormater(toTD, 'hh:mm');
  // "${"${toTD.hour}".padLeft(2, '0')}:${"${toTD.minute}".padLeft(2, '0')}"; //": 19:27

  Map<String, dynamic> jsonData = {
    "clientTxnId": '$randomNumber',
    "aPartyMsisdn": StoreManager.msisdn,
    "toneId": toneId,
    "language": StoreManager.languageCode,
    "priority": "0",
    "channelId": channelId,
    "bPartyMsisdn": bParty,
    "serviceId": "13",
    "activityId": "1",
    "packName": packName,
    "timeType": "3",
    "startDayMonthly": startDayMonthly,
    "endDayMonthly": endDayMonthly,
    "monthlyStartTime": monthlyStartTime,
    "monthlyEndTime": monthlyEndTime,
  };
  return await _postApi(tuneSettingDedicatedUrl, jsonData);
}

Future<TuneSettingModel> fulldayRepeatBaseYearlyDedicatedApi(String toneId,
    String bParty, String packName, DateTime fromTD, DateTime toTD) async {
  Random random = Random();
  var randomNumber = random.nextInt(1000000000);

  String yearlyStartMonth =
      dateFormater(fromTD, "MM"); //"${fromTD.month}".padLeft(2, '0'); //": 02,
  String yearlyEndMonth =
      dateFormater(toTD, "MM"); //"${toTD.month}".padLeft(2, '0'); //": 02,
  String yearlyStartDay =
      dateFormater(fromTD, "dd"); //"${fromTD.day}".padLeft(2, '0'); //": 28,
  String yearlyEndDay =
      dateFormater(toTD, "dd"); //"${toTD.day}".padLeft(2, '0'); //": 28,
  String yearlyStartTime = dateFormater(fromTD, "hh:mm");
  //"${"${fromTD.hour}".padLeft(2, '0')}:${"${fromTD.minute}".padLeft(2, '0')}"; //": 13:05,
  // "${fromTD.hour}".padLeft(2, '0')
  //     ":""${fromTD.minute}".padLeft(2, '0'); //": 10:05,
  String yearlyEndTime = dateFormater(toTD, "hh:mm");
  //"${"${toTD.hour}".padLeft(2, '0')}:${"${toTD.minute}".padLeft(2, '0')}"; //": 13:05,

  Map<String, dynamic> jsonData = {
    "clientTxnId": '$randomNumber',
    "aPartyMsisdn": StoreManager.msisdn,
    "toneId": toneId,
    "language": StoreManager.languageCode,
    "priority": "0",
    "channelId": channelId,
    "bPartyMsisdn": bParty,
    "serviceId": "13",
    "activityId": "1",
    "packName": packName,
    "timeType": "4",
    "yearlyStartMonth": yearlyStartMonth, //dateFormater('MM'),
    "yearlyEndMonth": yearlyEndMonth,
    "yearlyStartDay": yearlyStartDay,
    "yearlyEndDay": yearlyEndDay,
    "yearlyStartTime": yearlyStartTime,
    "yearlyEndTime": yearlyEndTime,
  };
  return await _postApi(tuneSettingDedicatedUrl, jsonData);
}

String dateFormater(DateTime date, String inFormate) {
  String formatted = '';
  try {
    DateTime now = date;
    final DateFormat formatter = DateFormat(inFormate); //'yyyy-MM-dd');
    formatted = formatter.format(now);
  } catch (e) {
    formatted = '';
  }

  return formatted;
}

Future<TuneSettingModel> _postApi(
    String url, Map<String, dynamic> formData) async {
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(url, formData: formData);
  TuneSettingModel model = TuneSettingModel.fromJson(jsonResp);
  return model;
}
