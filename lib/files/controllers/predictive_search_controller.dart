import 'package:get/state_manager.dart';
import 'package:mtn_ghana_wp/files/api_calls/artists_search_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_search_tune_list_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/tone_code_search_api.dart';
import 'package:mtn_ghana_wp/files/model/artists_model.dart';
import 'package:mtn_ghana_wp/files/model/search_result_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/api_calls/predictive_search_api/predictive_song_search_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/predictive_search_api/predictive_search_code_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/predictive_search_api/predictive_artist_search_api.dart';

class PredictiveSearchController {
  RxBool isLoadingSongName = false.obs;
  RxBool isLoadingArtistName = false.obs;
  RxBool isLoadingSongList = false.obs;
  RxBool isLoadingArtistList = false.obs;
  RxBool isLoadingCode = false.obs;
  RxInt selectedIndex = 0.obs;
  List<String> artistNameList = [];
  List<String> toneNameList = [];
  List<TuneInfo> codeList = [];
  List<ArtistList> artistList = [];
  List<TuneInfo> songList = [];
  _getToneList(String key) async {
    isLoadingSongName.value = true;
    toneNameList = await predictiveSongSearchApi(key);
    isLoadingSongName.value = false;
  }

  _getArtistList(String key) async {
    isLoadingArtistName.value = true;
    artistNameList = await predictiveArtistSearchApi(key);
    artistNameList = artistNameList.where((v) => v.isNotEmpty).toList();
    isLoadingArtistName.value = false;
  }

  getResultFor(String key) {
    artistNameList.clear();
    toneNameList.clear();
    codeList.clear();
    artistList.clear();
    songList.clear();
    _getToneList(key);
    _getArtistList(key);
    _searchCode(key);
  }

  void _searchCode(String key) async {
    isLoadingCode.value = true;
    codeList = await predictiveSearchCodeApi(key);
    isLoadingCode.value = false;
  }

  consolidatedResults(String key, {int selectedIndex = 0}) async {
    artistNameList.clear();
    toneNameList.clear();
    codeList.clear();
    artistList.clear();
    songList.clear();
    this.selectedIndex.value = selectedIndex;
    _songListSearch(key);
    _artistListSearch(key);
    _toneCodeList(key);
  }

  Future<void> _toneCodeList(String key) async {
    isLoadingSongList.value = true;
    SearchResultModel toneCodeResults = await getToneCodeSearchListApi(key);
    codeList = toneCodeResults.responseMap?.toneList ?? [];
    isLoadingSongList.value = false;
  }

  Future<void> _artistListSearch(String key) async {
    isLoadingArtistList.value = true;
    ArtistsModel artistsModel = await getArtistListApi(key);
    artistList = artistsModel.responseMap?.artistList ?? [];
    isLoadingArtistList.value = false;
  }

  Future<void> _songListSearch(String key) async {
    isLoadingSongList.value = true;
    SearchResultModel searchResults = await getSearchedTuneListApi(key);
    songList = searchResults.responseMap?.toneList ?? [];
    print("song list length is ${songList.length}");
    isLoadingSongList.value = false;
  }
}
