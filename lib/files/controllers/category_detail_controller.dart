import 'package:mtn_ghana_wp/files/api_calls/get_category_api_face.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_category_detail_api.dart';
import 'package:mtn_ghana_wp/files/model/category_detail_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:get/get.dart';

class CategoryDetailController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];
  RxInt totalTuneCount = 0.obs;
    String _key = '';

  String _catId = '';
  getCategoryDetailList(String catId) async {
    totalTuneCount.value = 0;

    _catId = catId;
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    CategoryDetailModel model = await getCategoryDetailApi(catId);
    tuneList = model.responseMap?.toneList ?? [];
    //totalTuneCount.value = model.responseMap?.t ?? 0;
    isLoading.value = false;
  }
   getCategoryDetailList1(String key, String catId) async {
    totalTuneCount.value = 0;
    _key = key;
    _catId = catId;
    if (isLoading.value) {
      return;
    }
    tuneList = _fakeData();
    isLoading.value = true;
    CategoryDetailModel model = await getCategoryDetailApi1(key, catId);
    tuneList = model.responseMap?.searchList ?? [];
    totalTuneCount.value = model.responseMap?.totalCount ?? 0;
    isLoading.value = false;
  }
  


   List<TuneInfo> _fakeData() {
    return [
      TuneInfo(),
      TuneInfo(),
      TuneInfo(),
      TuneInfo(),
      TuneInfo(),
      TuneInfo(),
    ];
  }
  loadMoreData(int index) async {
    isLoading.value = true;
    CategoryDetailModel model =
        await getCategoryDetailApi(_catId, pageNo: index);
    tuneList = model.responseMap?.toneList ?? [];
    isLoading.value = false;
  }
}
