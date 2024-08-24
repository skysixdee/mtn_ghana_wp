import 'package:etisalat/files/api_calls/get_banner_category_api.dart';
import 'package:etisalat/files/model/artist_tune_list_model.dart';
import 'package:get/get.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/model/banner_detail_model.dart';
import 'package:etisalat/files/api_calls/get_banner_detail_api.dart';

class BannerDetailController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];
  getBannerDetail(String type, String searchKey) async {
    tuneList.clear();
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    if (type == 'Category') {
      ArtistTuneListModel artistTuneListModel =
          await getBannerCategoryApi(type, searchKey);
      tuneList = artistTuneListModel.responseMap?.searchList ?? [];
    } else {
      BannerDetailModel model = await getBannerDetailApi(type, searchKey);
      tuneList = model.responseMap?.searchList ?? [];
    }

    isLoading.value = false;
  }
}
