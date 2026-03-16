import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/api_calls/category_search_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_app_setting.dart';
import 'package:mtn_ghana_wp/files/model/advanced_search_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';

class NewFeatureController extends GetxController {
  RxList<TuneCategory> categories = <TuneCategory>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTabList();
  }

  Future<void> getTabList() async {
    categories.clear();

    if (StoreManager.other == null) {
      await getAppSettingApi();
    }

    print(
        "featureTabCount: ${StoreManager.other?.featuredCatEnglish?.attribute}");

    List<String> featureTabCount =
        ((StoreManager.other?.featuredCatEnglish?.attribute) ?? '').split("|");

    for (var element in featureTabCount) {
      if (element.trim().isEmpty) continue;

      List<String> parts = element.split(',');

      if (parts.length >= 4) {
        String displayName = parts[0];
        //String name = parts[1];
        String id = parts[2];
        //String imageUrl = parts[3];
        var cat = TuneCategory(displayName, []);
        cat.isLoading.value = true;
        categories.add(cat);
        getTabDetail(id, cat); // async call
      }
    }
  }

  Future<void> getTabDetail(String id, TuneCategory cat) async {
    AdvancedSearchModal model = await categorySearchApi(id, pageNo: 1);
    List<TuneInfo> toneList = model.responseMap?.toneList ?? [];
    cat.tunes.assignAll(toneList);
    cat.isLoading.value = false;
  }
}

class TuneCategory {
  String title;
  RxBool isLoading = false.obs;
  RxList<TuneInfo> tunes;

  TuneCategory(this.title, List<TuneInfo> tunes) : tunes = tunes.obs;
}
