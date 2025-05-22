import 'package:mtn_ghana_wp/files/api_calls/category_search_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_app_setting.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_featured_list_api.dart';
import 'package:mtn_ghana_wp/files/google_tag_manager/google_tag_manager.dart';
import 'package:mtn_ghana_wp/files/model/advanced_search_model.dart';
import 'package:mtn_ghana_wp/files/model/feature_tab_model.dart';
import 'package:mtn_ghana_wp/files/model/fetured_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';
import 'package:get/get.dart';

class FeatureController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt index = 0.obs;
  List<FeatureTabModel> tabList = [];
  RxList<bool> isLoadingList = <bool>[].obs;
  final List<List<TuneInfo>> _listOfList = [];
  RxList<TuneInfo> displayList = <TuneInfo>[].obs;
  @override
  void onInit() {
    super.onInit();
    getFeaturedList();
  }

  getFeaturedList() async {
    isLoadingList.clear();
    displayList.clear();
    isLoadingList.clear();
    isLoading.value = true;
    if (StoreManager.other == null) {
      await getAppSettingApi();
    }

    List<String> featureTabCount =
        ((StoreManager.other?.featuredCatEnglish?.attribute)??'')//featuredCategoryEnglish?.attribute) ?? '')
            .split("|");
    tabList.clear();
    for (var element in featureTabCount) {
      String name = element.split(',')[0];
      String value = element.split(',')[1];
      String intValue = element.split(',')[2];
      tabList.add(FeatureTabModel(name, value, intValue));

      isLoadingList.add(false);
      _listOfList.add([]);
    }

    await loadTabIndex();
    isLoading.value = false;
  }

  updateTabIndex(int index) {
    this.index.value = index;
    loadTabIndex(index: index);
  }

  Future<void> loadTabIndex({int index = 0}) async {
    if (isLoadingList[index]) {
      customPrint("it is still loading");
      return;
    }
    if (_listOfList[index].isNotEmpty) {
      displayList.value = _listOfList[index];
      customPrint("list is not empty take value from here and display");
      return;
    }
    isLoadingList[index] = true;
    homePageCategoryBrowseEvent(
        tabList[index].name, tabList[index].intValue, tabList[index].value);
    //FeturedModel model = await getFeaturedListApi(tabList[index].value);
    //List<TuneInfo> list = model.responseMap?.recommendationSongsList ?? [];
    AdvancedSearchModal model =
            await categorySearchApi(tabList[index].intValue);
          //await advancedSearchScApi(tabList[index].intValue);
    List<TuneInfo> list = model.responseMap?.toneList ?? [];
    displayList.value = list;
    _listOfList[index] = list;
    isLoadingList[index] = false;
    return;
  }
}
