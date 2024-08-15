import 'package:etisalat/files/api_calls/get_banner_api.dart';
import 'package:etisalat/files/model/banner_model.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  RxInt selectedIndex = 0.obs;
  List<Banner> banners = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    BannerModel model = await getBannerApi();
    banners = model.responseMap?.banners ?? [];

    isLoading.value = false;
  }

  updatedSelectedIndex(int index) {
    print("index = $index");
    selectedIndex.value = index;
  }
}
