import 'package:etisalat/files/api_calls/get_app_setting.dart';
import 'package:etisalat/files/api_calls/get_featured_list_api.dart';
import 'package:etisalat/files/model/feature_tab_model.dart';
import 'package:etisalat/files/model/fetured_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/urls.dart';
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
    await Future.delayed(const Duration(seconds: 1));

    if (StomreManager.other == null) {
      await getAppSetting();
    }

    List<String> featureTabCount =
        ((StomreManager.other?.featuredCategoryEnglish?.attribute) ?? '')
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
      print("it is still loading");
      return;
    }
    if (_listOfList[index].isNotEmpty) {
      displayList.value = _listOfList[index];
      print("lst is not empty take value from here and display");
      return;
    }
    isLoadingList[index] = true;
    await Future.delayed(Duration(seconds: 5));
    FeturedModel model = await getFeturedListApi(tabList[index].value);
    List<TuneInfo> list = model.responseMap?.recommendationSongsList ?? [];
    displayList.value = list;
    _listOfList[index] = list;
    isLoadingList[index] = false;
    return;
  }
}
