import 'package:etisalat/files/api_calls/get_playing_tune_api.dart';
import 'package:etisalat/files/model/my_playing_tunes_model.dart';
import 'package:get/get.dart';

class MyPlayingTuneController extends GetxController {
  RxBool isLoading = false.obs;
  List<List<ToneDetail>> toneDetails = [];
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
      String serviceName = model.responseMap?.listToneApk?[i].serviceName ?? '';
      List<ToneDetail> lst =
          model.responseMap?.listToneApk?[i].toneDetails ?? [];
      if (serviceName == 'AllCaller' || serviceName == 'SpecialCallerSetting') {
        model.responseMap?.listToneApk?[i].toneDetails?.first.serviceName =
            serviceName;
        toneDetails.add(lst);

        print("added service name = $serviceName");
      } else {
        print("Not added service name = $serviceName");
      }
    }
  }
}
