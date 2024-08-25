import 'package:etisalat/files/api_calls/get_app_setting.dart';
import 'package:etisalat/files/api_calls/get_category_api.dart';
import 'package:etisalat/files/model/category_model.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';

import 'package:get/get.dart';

class AppController extends GetxController {
  RxList<Category> categories = <Category>[].obs;
  RxBool isLoggedIn = false.obs;
  @override
  void onInit() async {
    super.onInit();
    getAppSettingApi();
    CategoryModel categoryModel = await getCategoryApi();
    StoreManager.categories = categoryModel.responseMap?.categories ?? [];
    categories.value = categoryModel.responseMap?.categories ?? [];
  }
}
