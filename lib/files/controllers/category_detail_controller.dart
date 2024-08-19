import 'package:etisalat/files/api_calls/get_category_detail_api.dart';
import 'package:etisalat/files/model/category_detail_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:get/get.dart';

class CategoryDetailController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];

  getCategoryDetailList(String key, String catId) async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    CategoryDetailModel model = await getCategoryDetailApi(key, catId);
    tuneList = model.responseMap?.searchList ?? [];
    isLoading.value = false;
  }
}
