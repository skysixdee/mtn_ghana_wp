import 'package:etisalat/files/api_calls/get_app_setting.dart';
import 'package:etisalat/files/model/feature_tab_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/urls.dart';
import 'package:get/get.dart';

class FeatureController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt index = 0.obs;
  List<FeatureTabModel> tabList = [];
  @override
  void onInit() {
    super.onInit();
    getFeaturedList();
  }

  getFeaturedList() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 3));

    if (StomreManager.other == null) {
      print("Get featred list 12323");
      await getAppSetting();
    }
    print(
        "Get featred list ${StomreManager.other?.featuredCategoryEnglish?.attribute}");
    List<String> featureTabCount =
        ((StomreManager.other?.featuredCategoryEnglish?.attribute) ?? '')
            .split("|");
    tabList.clear();
    for (var element in featureTabCount) {
      print("element = $element");
      String name = element.split(',')[0];
      String value = element.split(',')[1];
      String intValue = element.split(',')[2];
      tabList.add(FeatureTabModel(name, value, intValue));
    }
    print("SKY = ${tabList.length}");

    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
  }

  updateTabIndex(int index) {
    this.index.value = index;
  }
}
