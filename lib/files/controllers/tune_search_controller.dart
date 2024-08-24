import 'package:etisalat/files/api_calls/get_search_tune_list_api.dart';
import 'package:etisalat/files/model/search_result_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:get/get.dart';

class TuneSearchController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];
  List<ArtistDetailList> artistList = [];
  String searchedText = '';
  RxInt selectedIndex = 0.obs;
  RxInt totalTuneCount = 0.obs;
  RxBool isLoadingMore = false.obs;
  String _key = '';
  getResult(String key) async {
    _key = key;
    totalTuneCount.value = 0;
    selectedIndex.value = 0;
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    SearchResultModel model = await getSearchedTuneListApi(key);
    tuneList = model.responseMap?.songList ?? [];
    totalTuneCount.value = model.responseMap?.toneTotalCount ?? 0;
    artistList = model.responseMap?.countList?.artistDetailList ?? [];
    //totalTuneCount.value = model.responseMap?.countList.artistDetailList. ?? 0;
    isLoading.value = false;
  }

  leadMoreData(int index) async {
    if (isLoadingMore.value) {
      return;
    }
    isLoadingMore.value = true;
    SearchResultModel model = await getSearchedTuneListApi(_key, pageNo: index);
    tuneList = model.responseMap?.songList ?? [];
    isLoadingMore.value = false;
  }
}
