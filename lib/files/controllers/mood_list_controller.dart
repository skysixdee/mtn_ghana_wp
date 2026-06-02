import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/api_calls/category_search_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_app_setting.dart';
import 'package:mtn_ghana_wp/files/model/advanced_search_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';

class MoodListController extends GetxController {
  RxList<MoodCategory> moods = <MoodCategory>[].obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    //getMoodTabList();
    super.onInit();
  }

  Future<void> getMoodTabList() async {
    moods.clear();

    if (StoreManager.other == null) {
      await getAppSettingApi();
    }

    List<String> featureTabCount =
        ((StoreManager.other?.moodListEnglish?.attribute) ?? '').split("|");

    for (var element in featureTabCount) {
      if (element.trim().isEmpty) continue;

      List<String> parts = element.split(',');

      if (parts.length >= 3) {
        String id = parts[0];
        String displayName = parts[1];

        var cat = MoodCategory(displayName, []);
        cat.isLoading.value = true;
        moods.add(cat);
        getTabDetail(id, cat); // async call
      }
    }
  }

  Future<void> getTabDetail(String id, MoodCategory cat) async {
    AdvancedSearchModal model = await categorySearchApi(id, pageNo: 1);
    List<TuneInfo> toneList = model.responseMap?.toneList ?? [];
    cat.tunes.assignAll(toneList);
    cat.isLoading.value = false;
  }
}

class MoodCategory {
  String title;
  RxBool isLoading = false.obs;
  RxList<TuneInfo> tunes;

  MoodCategory(this.title, List<TuneInfo> tunes) : tunes = tunes.obs;
}
