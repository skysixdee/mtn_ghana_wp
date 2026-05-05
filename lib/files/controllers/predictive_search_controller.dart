import 'package:get/state_manager.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/api_calls/predictive_search_api/predictive_song_search_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/predictive_search_api/predictive_search_code_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/predictive_search_api/predictive_artist_search_api.dart';

class PredictiveSearchController {
  RxBool isLoadingSong = false.obs;
  RxBool isLoadingArtist = false.obs;
  RxBool isLoadingCode = false.obs;
  List<String> artistList = [];
  List<String> toneList = [];
  List<TuneInfo> codeList = [];
  _getToneList(String key) async {
    isLoadingSong.value = true;
    toneList = await predictiveSongSearchApi(key);
    isLoadingSong.value = false;
  }

  _getArtistList(String key) async {
    isLoadingArtist.value = true;
    artistList = await predictiveArtistSearchApi(key);
    isLoadingArtist.value = false;
  }

  getResultFor(String key) {
    _getToneList(key);
    _getArtistList(key);
    _searchCode(key);
  }

  void _searchCode(String key) async {
    isLoadingCode.value = true;
    codeList = await predictiveSearchCodeApi(key);
    isLoadingCode.value = false;
  }
}
