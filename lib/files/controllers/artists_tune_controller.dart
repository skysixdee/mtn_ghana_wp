import 'package:mtn_ghana_wp/files/api_calls/get_artist_tunes_list_api.dart';
import 'package:mtn_ghana_wp/files/model/artist_tune_list_model.dart';
import 'package:mtn_ghana_wp/files/model/search_result_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:get/get.dart';

class ArtistsTuneController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = <TuneInfo>[].obs;
  RxInt totalToneCount = 0.obs;
  String _key = '';

  getArtistsTune(String key) async {
    _key = key;
    totalToneCount.value = 0;

    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    SearchResultModel model = await getArtistTuneListScApi(key);
    tuneList = model.responseMap?.toneList ?? [];
    totalToneCount.value = model.responseMap?.resultCount ?? 0;
    isLoading.value = false;
  }

  loadMoreData(int index) async {
    isLoading.value = true;
    SearchResultModel model = await getArtistTuneListScApi(_key, pageNo: index);
    tuneList = model.responseMap?.toneList ?? [];

    isLoading.value = false;
  }
}
