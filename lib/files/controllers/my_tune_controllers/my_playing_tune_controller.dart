import 'package:etisalat/files/api_calls/get_playing_tune_api.dart';
import 'package:etisalat/files/enums/playing_card_type.dart';
import 'package:etisalat/files/model/my_playing_tunes_model.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class MyPlayingTuneController extends GetxController {
  RxBool isLoading = false.obs;
  RxString message = ''.obs;
  List<ToneDetail> tuneList = [];
  RxBool isShuffleOn = false.obs;
  getPlayingTune() async {
    message.value = '';
    isLoading.value = true;
    MyPlayingTunesModel model = await getMyPlayingTuneApi();
    print("model = $model");
    if (model.statusCode == 'SC0000') {
      int len = model.responseMap?.listToneApk?.length ?? 0;
      await craeteCardList(len, model);
      message.value = tuneList.isEmpty ? listIsEmptyStr : '';
    } else {
      message.value = model.message ?? someThingWentWrongStr;
    }

    isLoading.value = false;
  }

  Future<void> craeteCardList(int len, MyPlayingTunesModel model) async {
    tuneList.clear();
    for (var i = 0; i < len; i++) {
      PlayingListToneApk? listToneApk = model.responseMap?.listToneApk?[i];
      String serviceName = listToneApk?.serviceName ?? '';
      String bParty = listToneApk?.msisdnB ?? '';

      List<ToneDetail> lst = listToneApk?.toneDetails ?? [];

      if (serviceName == 'AllCaller' || serviceName == 'SpecialCallerSetting') {
        listToneApk?.toneDetails?.first.serviceName = serviceName;

        ToneDetail info = lst.first;
        isShuffleOn.value = (info.isShuffle == "T") ? true : false;
        if (info.customiseStartDate != '0') {
          tuneList.add(
              createNewList(info, PlayingCardType.none, serviceName, bParty));
          if (kDebugMode) {
            customPrint("none ");
          }
        }
        if (info.endDayMonthly != '0') {
          tuneList.add(createNewList(
              info, PlayingCardType.monthly, serviceName, bParty));
          customPrint("SKY MONTHLY");
        }
        if (info.yearlyEndMonth != '0') {
          tuneList.add(
              createNewList(info, PlayingCardType.yearly, serviceName, bParty));
          customPrint("SKY YEARLY");
        }
        if (info.startTimeWeekly == "00:00:00" &&
            info.endTimeWeekly != "00:00:00") {
          tuneList.add(createNewList(
              info, PlayingCardType.fullday, serviceName, bParty));
          customPrint("SKY full day ");
        }
        if (info.endTimeWeekly != "00:00:00" &&
            info.startTimeWeekly != "00:00:00") {
          tuneList.add(createNewList(
              info, PlayingCardType.customTime, serviceName, bParty));
          customPrint("SKY Custom time base ");
        }
      }
    }
    customPrint("total new list = ${tuneList.length}");
    return;
  }

  ToneDetail createNewList(ToneDetail info, PlayingCardType type,
      String serviceName, String bParty) {
    ToneDetail inf = ToneDetail();
    inf.playingCardType = type;
    inf.bParty = bParty;
    inf.albumName = info.albumName;
    inf.artistName = info.artistName;
    inf.createdDate = info.createdDate;
    inf.customiseEndDate = info.customiseEndDate;
    inf.customiseEndTime = info.customiseEndTime;
    inf.customiseStartDate = info.customiseStartDate;
    inf.customiseStartTime = info.customiseStartTime;
    inf.endDayMonthly = info.endDayMonthly;
    inf.endTime = info.endTime;
    inf.endTimeMonthly = info.endTimeMonthly;
    inf.endTimeWeekly = info.endTimeWeekly;
    inf.isShuffle = info.isShuffle;
    inf.playingCardType = type;
    inf.previewImageUrl = info.previewImageUrl;
    inf.price = info.price;
    inf.serviceName = serviceName;
    inf.startDayMonthly = info.startDayMonthly;
    inf.startTime = info.startTime;
    inf.startTimeMonthly = info.startTimeMonthly;
    inf.startTimeWeekly = info.startTimeWeekly;
    inf.status = info.status;
    inf.toneId = info.toneId;
    inf.toneIdStreamingUrl = info.toneIdStreamingUrl;
    inf.toneIdpreviewImageUrl = info.toneIdpreviewImageUrl;
    inf.toneName = info.toneName;
    inf.toneUrl = info.toneName;
    inf.toneUrl = info.toneUrl;
    inf.weeklyDays = info.weeklyDays;
    inf.yearlyEndDay = info.yearlyEndDay;
    inf.yearlyEndMonth = info.yearlyEndMonth;
    inf.yearlyEndTime = info.yearlyEndTime;
    inf.yearlyStartDay = info.yearlyStartDay;
    inf.yearlyStartMonth = info.yearlyStartMonth;
    inf.yearlyStartTime = info.yearlyStartTime;
    return inf;
  }
}
