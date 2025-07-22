import 'package:mtn_ghana_wp/files/api_calls/dedicated_tune_delete_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/delete_from_shuffle_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_my_music_box_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_playing_tune_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/shuffle_enable_disable_api.dart';
import 'package:mtn_ghana_wp/files/enums/playing_card_type.dart';
import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/my_music_box_model.dart';
import 'package:mtn_ghana_wp/files/model/my_playing_tunes_model.dart';
import 'package:mtn_ghana_wp/files/model/my_tunes_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/snack_bar.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_screen/my_music_box_view/my_music_box_content.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class MyPlayingTuneController extends GetxController {
  RxBool isLoading = false.obs;
  RxString message = ''.obs;
  RxList<ToneDetail> tuneList = <ToneDetail>[].obs;
  RxBool isShuffleOn = false.obs;
  List<TuneInfo> musicList = [];
  RxBool switchingShuffle = false.obs;

  getPlayingTune() async {
    if (isLoading.value) {
      return;
    }
    message.value = '';
    isLoading.value = true;
    musicList = await _getMusicBox();
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

  Future<List<TuneInfo>> _getMusicBox() async {
    List<TuneInfo> tuneList1 = [];
    MyTunesModel model = await getMyMusicBoxApi();
    if (model.respCode == 0) {
      tuneList1 = model.responseMap?.tonelist ?? [];
    }
    return tuneList1;
  }

  enabelDispableShuffle() async {
    openAlertPopup(
      message: isShuffleOn.value
          ? disableShuffleMessageStr
          : doYouWantToEnableShuffleStr,
      primaryBtnTitle: confirmStr,
      secondryBtnTitle: cancelStr,
      onPrimary: () async {
        switchingShuffle.value = true;
        GenericModel model = await shuffleEnbleDisableApi(!isShuffleOn.value);
        if (model.respCode == 0) {
          isShuffleOn.value = !isShuffleOn.value;
          getPlayingTune();
        } else {
          snackBar(model.message);
        }
        switchingShuffle.value = false;
      },
    );
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

  deleteTune(ToneDetail detail) {
    openAlertPopup(
      message: deletePlayingTuneMessageStr,
      secondryBtnTitle: cancelStr,
      onPrimary: () {
        print("Delete tone name ===== ${detail.toneName}");
        if (detail.serviceName == 'SpecialCallerSetting') {
          _deleteDedicatedTune(detail);
        } else {
          _deleteAllCallerTune(detail);
        }
      },
    );
  }

  _deleteDedicatedTune(ToneDetail info) async {
    GenericModel model = await dedicatedTuneDeleteScApi(
        info.bParty ?? '', info.toneId ?? '', getTimeType(info));
    if (model.respCode == 0) {
      tuneList.remove(info);
    } else {
      snackBar(model.message);
    }
    print("Dedicated deleted");
  }

  _deleteAllCallerTune(ToneDetail info) async {
    GenericModel model =
        await deleteFromShuffleScApi(info.toneId ?? '', getTimeType(info));
    if (model.respCode == 0) {
      tuneList.remove(info);
    } else {
      snackBar(model.message);
    }

    print("AllCaller deleted");
  }

  getTimeType(ToneDetail info) {
    PlayingCardType? type = info.playingCardType;

    if (info.serviceName == "AllCaller" ||
        info.serviceName == "SpecialCallerSetting") {
      if (type == PlayingCardType.yearly) {
        return '4';
      } else if (type == PlayingCardType.monthly) {
        return "3";
      } else if (type == PlayingCardType.none) {
        return "7";
      } else if (type == PlayingCardType.fullday) {
        return "2";
      } else if (type == PlayingCardType.customTime) {
        return "2";
      } else {
        print("please check card type here");
      }
    } else {
      print("please check time type her and return valid it ");
      return "1";
    }
    // timeType
  }
}

/*
else if (info.serviceName == "SpecialCallerSetting") {
      if (type == PlayingCardType.yearly) {
        return '4';
      } else if (type == PlayingCardType.monthly) {
        return "3";
      } else if (type == PlayingCardType.none) {
        return "7";
      } else if (type == PlayingCardType.fullday) {
        return "2";
      } else if (type == PlayingCardType.customTime) {
        return "2";
      } else {
        print("please check card type here");
      }
    } 
*/
