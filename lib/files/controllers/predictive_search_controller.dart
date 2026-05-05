import 'package:get/state_manager.dart';
import 'package:mtn_ghana_wp/files/api_calls/artists_search_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_search_tune_list_api.dart';
import 'package:mtn_ghana_wp/files/model/artists_model.dart';
import 'package:mtn_ghana_wp/files/model/search_result_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';

class PredictiveSearchController {
  RxBool isLoadingSong = false.obs;
  RxBool isLoadingArtist = false.obs;
  List<ArtistList> artistList = [];
  List<TuneInfo> toneList = [];
  getToneList(String key) async {
    isLoadingSong.value = true;
    SearchResultModel model = await getSearchedTuneListApi(key);
    toneList = model.responseMap?.toneList ?? [];
    isLoadingSong.value = false;
  }

  getArtistList(String key) async {
    isLoadingArtist.value = true;
    ArtistsModel model = await getArtistListApi(key);
    artistList = model.responseMap?.artistList ?? [];
    isLoadingArtist.value = false;
  }

  getResultFor(String key) {
    getToneList(key);
    getArtistList(key);
  }
}
