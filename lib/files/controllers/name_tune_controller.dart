import 'package:etisalat/files/api_calls/get_name_tune_api.dart';
import 'package:etisalat/files/model/name_tune_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:get/get.dart';

class NameTuneController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];

  getNameTune() async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    NameTuneModel model = await getNameTuneApi();
    tuneList = model.responseMap?.songList ?? [];
    isLoading.value = false;
  }
}
