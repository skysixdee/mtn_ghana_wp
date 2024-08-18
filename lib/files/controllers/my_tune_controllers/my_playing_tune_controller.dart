import 'package:etisalat/files/api_calls/get_playing_tune_api.dart';
import 'package:etisalat/files/model/my_playing_tunes_model.dart';
import 'package:get/get.dart';

class MyPlayingTuneController extends GetxController {
  RxBool isLoading = false.obs;
  List<List<ToneDetail>> toneDetails = [];
  RxBool isShuffleOn = false.obs;
  getPlayingTune() async {
    toneDetails.clear();
    isLoading.value = true;
    MyPlayingTunesModel model = await getMyPlayingTuneApi();
    int len = model.responseMap?.listToneApk?.length ?? 0;
    craeteCardList(len, model);
    isLoading.value = false;
  }

  void craeteCardList(int len, MyPlayingTunesModel model) {
    for (var i = 0; i < len; i++) {
      PlayingListToneApk? listToneApk = model.responseMap?.listToneApk?[i];
      String serviceName = listToneApk?.serviceName ?? '';
      List<ToneDetail> lst = listToneApk?.toneDetails ?? [];

      if (serviceName == 'AllCaller' || serviceName == 'SpecialCallerSetting') {
        listToneApk?.toneDetails?.first.serviceName = serviceName;
        toneDetails.add(lst);
        ToneDetail info = lst.first;
        isShuffleOn.value = (info.isShuffle == "T") ? true : false;
        print("added service name = $serviceName");
        if (info.customiseStartDate != '0') {
          print("none");
        }
        if (info.endDayMonthly != '0') {
          print("SKY MONTHLY");
        }
        if (info.yearlyEndMonth != '0') {
          print("SKY YEARLY");
        }
        if (info.startTimeWeekly == "00:00:00" &&
            info.endTimeWeekly != "00:00:00") {
          print("SKY full day ");
        }
        if (info.endTimeWeekly != "00:00:00" &&
            info.startTimeWeekly != "00:00:00") {
          print("SKY Custom time base ");
        }
      } else {
        print("Not added service name = $serviceName");
      }
    }
  }
}
