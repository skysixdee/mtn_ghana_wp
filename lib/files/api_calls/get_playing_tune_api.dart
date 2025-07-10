import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/my_playing_tunes_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<MyPlayingTunesModel> getMyPlayingTuneApi({int pageNo = 0}) async {
  Map<String, dynamic> jsonMap = {
    "transactionId": getTransactionId(),
    "featureId": "1",
    "msisdn": StoreManager.msisdn,
    "languageCode": StoreManager.languageSort,
    "channelId": channelId,
    "serviceId": "1"
  };

  Map<String, dynamic> map =
      await NetworkManager().post(playingTuneUrl, jsonData: jsonMap);
  return myPlayingTunesModelFromJson(json.encode(map));
}

String json12 = """{
    "responseMap": {
        "listToneApk": [
            {
                "packUserDetails_Crbt": {
                    "isShuffle": "T",
                    "isSuspend": "F",
                    "language": "Zawgyi",
                    "packExpiry": "2024-08-19T22:16:56+06:30",
                    "packName": "EAUC",
                    "serialNo": "0",
                    "serviceType": "CRBT"
                },
                "serviceName": "PACK_DETAILS",
                "groupId": 0
            },
            {
                "toneDetails": [
                    {
                        "toneId": "1592804214",
                        "toneName": "A TAUNG PAN PAR YIN MIN SI KO CHO",
                        "toneUrl": "https://ringtune.mpt.com.mm/stream-media/get-tone-path?fileId\u003dad2y1Ryf3ICAB5xpi4G8/OOr4AVCl4iSLwjl2T6VXYqAocZWmgIg3a7/ZCVu8iMsq8gOQRHyBCPh9vaYTDTJE5qI7q0xYLpdyU8gvnExZhI\u003d",
                        "previewImageUrl": "https://ringtune.mpt.com.mm/stream-media/get-preview-image?fileId\u003dad2y1Ryf3ICAB5xpi4G8/OOr4AVCl4iSeaE4oHyZYNNVwbkOAud3m7loAHYsffOc6795dln9PHHbCOybVwFzPztZNAtbdPZj30aeSk+ZVtU\u003d",
                        "albumName": "THAN THA YAR",
                        "artistName": "SOE PAING",
                        "price": 0.0,
                        "createdDate": "18/08/2024",
                        "status": "A",
                        "endTime": "00:00:00",
                        "startTime": "00:00:00",
                        "endDayMonthly": "0",
                        "endTimeMonthly": "23:59:59",
                        "startDayMonthly": "0",
                        "startTimeMonthly": "00:00:00",
                        "endTimeWeekly": "23:59:59",
                        "startTimeWeekly": "00:00:00",
                        "weeklyDays": "3",
                        "customiseEndDate": "2024-08-27",
                        "customiseEndTime": "21:28:00",
                        "customiseStartDate": "2024-08-18",
                        "customiseStartTime": "21:28:00",
                        "yearlyEndDay": "31",
                        "yearlyEndMonth": "08",
                        "yearlyEndTime": "21:29:59",
                        "yearlyStartDay": "18",
                        "yearlyStartMonth": "08",
                        "yearlyStartTime": "21:29:00",
                        "toneIdStreamingUrl": "https://ringtune.mpt.com.mm/stream-media/get-tone-path?fileId\u003d7S4PsIs1kaJ3j1oaHWuktg\u003d\u003d",
                        "toneIdpreviewImageUrl": "https://ringtune.mpt.com.mm/stream-media/get-preview-image?fileId\u003d7S4PsIs1kaJ3j1oaHWuktg\u003d\u003d"
                    }
                ],
                "serviceName": "SpecialCallerSetting",
                "msisdnB": "08123812513",
                "groupId": 0
            },
            {
                "toneDetails": [
                    {
                        "toneId": "1592293214",
                        "toneName": "YWAT HLWINT V1",
                        "toneUrl": "https://ringtune.mpt.com.mm/stream-media/get-tone-path?fileId\u003dad2y1Ryf3ICAB5xpi4G8/OOr4AVCl4iS4bPau8Ds+3w4JTfsIXKGGJHNT00c535YY3kqTBUBTp1aGnCAYTpQYQ\u003d\u003d",
                        "previewImageUrl": "https://ringtune.mpt.com.mm/stream-media/get-preview-image?fileId\u003dad2y1Ryf3ICAB5xpi4G8/OOr4AVCl4iSeaE4oHyZYNO89s/n/G+lAwmtHv9H77afmzYNX5GB5Piyo0IieQ3Gyn2hvjv5Cya/30aeSk+ZVtU\u003d",
                        "albumName": "YWAT HLWINT",
                        "artistName": "JAY",
                        "price": 0.0,
                        "createdDate": "18/08/2024",
                        "status": "A",
                        "endTime": "00:00:00",
                        "startTime": "00:00:00",
                        "endDayMonthly": "20",
                        "endTimeMonthly": "21:29:59",
                        "startDayMonthly": "18",
                        "startTimeMonthly": "21:29:00",
                        "endTimeWeekly": "21:31:59",
                        "startTimeWeekly": "21:28:00",
                        "weeklyDays": "5,4",
                        "customiseEndDate": "0",
                        "customiseEndTime": "23:59:59",
                        "customiseStartDate": "0",
                        "customiseStartTime": "00:00:00",
                        "yearlyEndDay": "0",
                        "yearlyEndMonth": "0",
                        "yearlyEndTime": "23:59:59",
                        "yearlyStartDay": "0",
                        "yearlyStartMonth": "0",
                        "yearlyStartTime": "00:00:00",
                        "toneIdStreamingUrl": "https://ringtune.mpt.com.mm/stream-media/get-tone-path?fileId\u003dMCVWZ8WnMH13j1oaHWuktg\u003d\u003d",
                        "toneIdpreviewImageUrl": "https://ringtune.mpt.com.mm/stream-media/get-preview-image?fileId\u003dMCVWZ8WnMH13j1oaHWuktg\u003d\u003d"
                    }
                ],
                "serviceName": "SpecialCallerSetting",
                "msisdnB": "08123812513",
                "groupId": 0
            },
            {
                "toneDetails": [
                    {
                        "toneId": "1592293214",
                        "toneName": "YWAT HLWINT V1",
                        "toneUrl": "https://ringtune.mpt.com.mm/stream-media/get-tone-path?fileId\u003dad2y1Ryf3ICAB5xpi4G8/OOr4AVCl4iS4bPau8Ds+3w4JTfsIXKGGJHNT00c535YY3kqTBUBTp1aGnCAYTpQYQ\u003d\u003d",
                        "previewImageUrl": "https://ringtune.mpt.com.mm/stream-media/get-preview-image?fileId\u003dad2y1Ryf3ICAB5xpi4G8/OOr4AVCl4iSeaE4oHyZYNO89s/n/G+lAwmtHv9H77afmzYNX5GB5Piyo0IieQ3Gyn2hvjv5Cya/30aeSk+ZVtU\u003d",
                        "albumName": "YWAT HLWINT",
                        "artistName": "JAY",
                        "price": 0.0,
                        "createdDate": "18/08/2024",
                        "isShuffle": "T",
                        "status": "A",
                        "endTime": "00:00:00",
                        "startTime": "00:00:00",
                        "endDayMonthly": "0",
                        "endTimeMonthly": "23:59:59",
                        "startDayMonthly": "0",
                        "startTimeMonthly": "00:00:00",
                        "endTimeWeekly": "23:59:59",
                        "startTimeWeekly": "00:00:00",
                        "weeklyDays": "3,2",
                        "customiseEndDate": "2024-08-28",
                        "customiseEndTime": "21:28:00",
                        "customiseStartDate": "2024-08-18",
                        "customiseStartTime": "21:26:00",
                        "yearlyEndDay": "0",
                        "yearlyEndMonth": "0",
                        "yearlyEndTime": "23:59:59",
                        "yearlyStartDay": "0",
                        "yearlyStartMonth": "0",
                        "yearlyStartTime": "00:00:00",
                        "toneIdStreamingUrl": "https://ringtune.mpt.com.mm/stream-media/get-tone-path?fileId\u003dMCVWZ8WnMH13j1oaHWuktg\u003d\u003d",
                        "toneIdpreviewImageUrl": "https://ringtune.mpt.com.mm/stream-media/get-preview-image?fileId\u003dMCVWZ8WnMH13j1oaHWuktg\u003d\u003d"
                    }
                ],
                "serviceName": "AllCaller",
                "groupId": 0
            },
            {
                "toneDetails": [
                    {
                        "toneId": "1592804214",
                        "toneName": "A TAUNG PAN PAR YIN MIN SI KO CHO",
                        "toneUrl": "https://ringtune.mpt.com.mm/stream-media/get-tone-path?fileId\u003dad2y1Ryf3ICAB5xpi4G8/OOr4AVCl4iSLwjl2T6VXYqAocZWmgIg3a7/ZCVu8iMsq8gOQRHyBCPh9vaYTDTJE5qI7q0xYLpdyU8gvnExZhI\u003d",
                        "previewImageUrl": "https://ringtune.mpt.com.mm/stream-media/get-preview-image?fileId\u003dad2y1Ryf3ICAB5xpi4G8/OOr4AVCl4iSeaE4oHyZYNNVwbkOAud3m7loAHYsffOc6795dln9PHHbCOybVwFzPztZNAtbdPZj30aeSk+ZVtU\u003d",
                        "albumName": "THAN THA YAR",
                        "artistName": "SOE PAING",
                        "price": 0.0,
                        "createdDate": "18/08/2024",
                        "isShuffle": "T",
                        "status": "A",
                        "endTime": "00:00:00",
                        "startTime": "00:00:00",
                        "endDayMonthly": "29",
                        "endTimeMonthly": "21:27:59",
                        "startDayMonthly": "18",
                        "startTimeMonthly": "21:27:00",
                        "endTimeWeekly": "23:59:59",
                        "startTimeWeekly": "00:00:00",
                        "weeklyDays": "0",
                        "customiseEndDate": "0",
                        "customiseEndTime": "23:59:59",
                        "customiseStartDate": "0",
                        "customiseStartTime": "00:00:00",
                        "yearlyEndDay": "30",
                        "yearlyEndMonth": "08",
                        "yearlyEndTime": "21:27:59",
                        "yearlyStartDay": "18",
                        "yearlyStartMonth": "08",
                        "yearlyStartTime": "21:27:00",
                        "toneIdStreamingUrl": "https://ringtune.mpt.com.mm/stream-media/get-tone-path?fileId\u003d7S4PsIs1kaJ3j1oaHWuktg\u003d\u003d",
                        "toneIdpreviewImageUrl": "https://ringtune.mpt.com.mm/stream-media/get-preview-image?fileId\u003d7S4PsIs1kaJ3j1oaHWuktg\u003d\u003d"
                    }
                ],
                "serviceName": "AllCaller",
                "groupId": 0
            }
        ]
    },
    "message": "Success",
    "respTime": "Aug 19, 2024 12:08:36 AM",
    "statusCode": "SC0000"
}""";
