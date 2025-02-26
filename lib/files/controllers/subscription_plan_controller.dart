import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mtn_ghana_wp/files/model/subscription_pack_list_model.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';

class SubscriptionPlanController extends GetxController {
  List<SubscriptionPackListModel> packList = [];
  RxInt selectedIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    createPackList();
  }

  createPackList() {
    String attributes = StoreManager.other?.packnameEnglish?.attribute ?? '';
    List<String> packDetailList = attributes.split("|");
    for (String item in packDetailList) {
      String title = '';
      String value = '';
      String price = '';
      try {
        title = item.split(",")[0];
      } catch (e) {}
      try {
        value = item.split(",")[1];
      } catch (e) {}
      try {
        price = item.split(",")[2];
      } catch (e) {}
      packList.add(SubscriptionPackListModel(title, value, price));
    }
  }

  updateOnSelection(int value) {
    selectedIndex.value = value;
  }
}
