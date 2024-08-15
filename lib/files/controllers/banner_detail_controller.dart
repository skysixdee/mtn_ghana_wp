import 'package:get/get.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/model/banner_detail_model.dart';
import 'package:etisalat/files/api_calls/get_banner_detail_api.dart';

class BannerDetailController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];
  getBannerDetail(String type, String searchKey) async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    BannerDetailModel model = await getBannerDetailApi(type, searchKey);
    tuneList = model.responseMap?.searchList ?? [];
    isLoading.value = false;
  }
}
