import 'package:mtn_ghana_wp/files/api_calls/get_name_tune_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/search_nametune_api.dart';
import 'package:mtn_ghana_wp/files/model/artist_tune_list_model.dart';
import 'package:mtn_ghana_wp/files/model/name_tune_model.dart';
import 'package:mtn_ghana_wp/files/model/search_result_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/snack_bar.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:get/get.dart';

class NameTuneController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<TuneInfo> tuneList = <TuneInfo>[].obs;
  RxInt totalToneCount = 0.obs;
  String searchedName = '';
  bool isSearch = false;
  getNameTune() async {
    isSearch = false;
    searchedName = '';
    totalToneCount.value = 0;
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    NameTuneModel model = await getNameTuneApi();
    tuneList.value = model.responseMap?.songList ?? [];
    totalToneCount.value = model.responseMap?.songTotalCount ?? 0;
    isLoading.value = false;
  }

  loadMoreData(int index) async {
    isLoading.value = true;
    NameTuneModel model = await getNameTuneApi(pageNo: index);
    tuneList.value = model.responseMap?.songList ?? [];
    isLoading.value = false;
  }

  searchNameTune(String key) async {
    if (key.isEmpty) {
      openAlertPopup(message: enterTexttoSearchStr);
      //customSnackBar(enterTexttoSearchStr);
      return;
    }
    isSearch = true;
    searchedName = key;
    totalToneCount.value = 0;
    isLoading.value = true;
    SearchResultModel model = await searchNameTuneApi(key);
    totalToneCount.value = model.responseMap?.songTotalCount ?? 0;
    tuneList.value = model.responseMap?.songList ?? [];
    isLoading.value = false;
  }

  loadMoreSearchedData(int index) async {
    isLoading.value = true;
    SearchResultModel model =
        await searchNameTuneApi(searchedName, pageNo: index);
    tuneList.value = model.responseMap?.songList ?? [];

    isLoading.value = false;
  }
}
