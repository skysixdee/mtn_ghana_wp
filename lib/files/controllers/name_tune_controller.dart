import 'package:etisalat/files/api_calls/get_name_tune_api.dart';
import 'package:etisalat/files/model/name_tune_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:get/get.dart';

class NameTuneController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];
  RxInt totalToneCount = 0.obs;
  getNameTune() async {
    totalToneCount.value = 0;
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    NameTuneModel model = await getNameTuneApi();
    tuneList = model.responseMap?.songList ?? [];
    totalToneCount.value = model.responseMap?.songTotalCount ?? 0;
    isLoading.value = false;
  }

  loadMoreData(int index) async {
    isLoading.value = true;
    NameTuneModel model = await getNameTuneApi(pageNo: index);
    tuneList = model.responseMap?.songList ?? [];
    isLoading.value = false;
  }
}
