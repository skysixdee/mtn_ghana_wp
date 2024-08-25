import 'package:etisalat/files/api_calls/get_category_detail_api.dart';
import 'package:etisalat/files/model/category_detail_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:get/get.dart';

class CategoryDetailController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];
  RxInt totalTuneCount = 0.obs;
  String _key = '';
  String _catId = '';
  getCategoryDetailList(String key, String catId) async {
    _key = key;
    _catId = catId;
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    CategoryDetailModel model = await getCategoryDetailApi(key, catId);
    tuneList = model.responseMap?.searchList ?? [];
    totalTuneCount.value = model.responseMap?.totalCount ?? 0;
    isLoading.value = false;
  }

  loadMoreData(int index) async {
    isLoading.value = true;
    CategoryDetailModel model =
        await getCategoryDetailApi(_key, _catId, pageNo: index);
    tuneList = model.responseMap?.searchList ?? [];
    isLoading.value = false;
  }
}
