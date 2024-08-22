import 'package:etisalat/files/api_calls/get_my_music_box_api.dart';
import 'package:etisalat/files/model/my_music_box_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:get/get.dart';

class MyMusicBoxController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];
  getMyMusicBoxTune() async {
    isLoading.value = true;
    MyMusicBoxModel model = await getMyMusicBoxApi();
    if (model.statusCode == 'SC0000') {
      tuneList = model.responseMap?.listToneApk?.first.toneDetails ?? [];
    }

    isLoading.value = false;
  }
}
