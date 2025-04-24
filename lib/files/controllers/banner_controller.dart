import 'package:mtn_ghana_wp/files/api_calls/get_banner_api.dart';
import 'package:mtn_ghana_wp/files/model/banner_model.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  RxInt selectedIndex = 0.obs;
  List<BannerList> banners = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    BannerModel model = await getBannerScApi();
    banners = model.responseMap?.bannerList ?? [];
    print("________gokul________:${banners}");
    isLoading.value = false;
  }

  updatedSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
