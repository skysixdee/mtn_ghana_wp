import 'package:mtn_ghana_wp/files/api_calls/artists_search_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_search_tune_list_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/tone_code_search_api.dart';
import 'package:mtn_ghana_wp/files/model/artists_model.dart';
import 'package:mtn_ghana_wp/files/model/search_result_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:get/get.dart';

class TuneSearchController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];
  List<ArtistList> artistsList = [];
  //List<TuneInfo> tuneIdList = [];

  String searchedText = '';
  //RxInt selectedIndex = 0.obs;
  RxInt searchTypeIndex = 0.obs;
  RxInt totalTuneCount = 0.obs;
  RxBool isLoadingMore = false.obs;
  String _key = '';
  getSongSearchResult(String key) async {
    print('Searcing result for $key');
    //this.searchTypeIndex.value = searchTypeIndex;
    _key = key;
    totalTuneCount.value = 0;
    //selectedIndex.value = 0;
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    SearchResultModel model = await getSearchedTuneListApi(key);
    tuneList = model.responseMap?.toneList ?? [];
    // totalTuneCount.value = model.responseMap?.toneTotalCount ?? 0;
    // artistList = model.responseMap?.countList?.artistDetailList ?? [];
    //totalTuneCount.value = model.responseMap?.countList.artistDetailList. ?? 0;
    isLoading.value = false;
  }

  getSongCodeSearch(String key) async {
    _key = key;
    totalTuneCount.value = 0;
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    SearchResultModel model = await getToneCodeSearchListApi(key);
    tuneList = model.responseMap?.toneList ?? [];
    isLoading.value = false;
  }

  getArtistSearch(String key) async {
    _key = key;
    totalTuneCount.value = 0;
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    ArtistsModel model = await getArtistListApi(key);
    artistsList = model.responseMap?.artistList ?? [];
    print("hello ==============${artistsList.length}");
    isLoading.value = false;
  }

  leadMoreData(int index) async {
    if (isLoadingMore.value) {
      return;
    }

    isLoadingMore.value = true;
    if (searchTypeIndex.value == 2) {
      SearchResultModel model = await getToneCodeSearchListApi(_key);
      tuneList = model.responseMap?.toneList ?? [];
    } else if (searchTypeIndex.value == 1) {
      ArtistsModel model = await getArtistListApi(_key);
      artistsList = model.responseMap?.artistList ?? [];
    } else {
      SearchResultModel model =
          await getSearchedTuneListApi(_key, pageNo: index);
      tuneList = model.responseMap?.toneList ?? [];
    }
    isLoadingMore.value = false;
  }
}
