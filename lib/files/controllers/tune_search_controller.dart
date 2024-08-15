import 'package:etisalat/files/api_calls/get_search_tune_list_api.dart';
import 'package:etisalat/files/model/search_result_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:get/get.dart';

class TuneSearchController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];

  getResult(String key) async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    SearchResultModel model = await getSearchedTuneListApi(key);
    tuneList = model.responseMap?.songList ?? [];
    isLoading.value = false;
  }
}
