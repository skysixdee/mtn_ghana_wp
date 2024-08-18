import 'package:etisalat/files/api_calls/get_my_tune_api.dart';
import 'package:etisalat/files/model/my_tunes_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:get/get.dart';

class MyTuneController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];
  getMyTune() async {
    isLoading.value = true;
    MyTunesModel model = await getMyTuneApi();
    tuneList = model.responseMap?.listToneApk?.first.toneDetails ?? [];
    isLoading.value = false;
  }
}
