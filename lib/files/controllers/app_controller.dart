import 'package:mtn_ghana_wp/files/api_calls/get_app_setting.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_category_api.dart';
import 'package:mtn_ghana_wp/files/model/category_model.dart';
import 'package:mtn_ghana_wp/files/model/category_mw_model.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';

import 'package:get/get.dart';

// class AppController extends GetxController {
//   RxList<Category> categories = <Category>[].obs;
//   RxList<CategoryMw> categoriesMw = <CategoryMw>[].obs;
//   RxBool isLoggedIn = false.obs;
//   @override
//   void onInit() async {
//     super.onInit();
//     getAppSettingApi();
//     CategoryMwModel categoryModel = await getCategoryApi();
//     StoreManager.categoriesMw = categoryModel.responseMap?.categories ?? [];
//     categoriesMw.value = categoryModel.responseMap?.categories ?? [];
//   }
// }

class AppController extends GetxController {
  RxList<Category> categories = <Category>[].obs;
  RxBool isLoggedIn = false.obs;
  String headerIncrechmentMsisdn = "";
  @override
  void onInit() async {
    super.onInit();
    getAppSettingApi();
    CategoryModel categoryModel = await getCategoryScApi();
    //await Future.delayed(const Duration(seconds: 5));
    StoreManager.categories = categoryModel.responseMap?.categoryList ?? [];
    print("SKY list =${StoreManager.categories?.length}");
    categories.value = categoryModel.responseMap?.categoryList ?? [];
  }
}
