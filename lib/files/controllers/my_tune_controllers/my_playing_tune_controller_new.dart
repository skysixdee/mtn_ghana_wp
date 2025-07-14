import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mtn_ghana_wp/files/api_calls/list_setting_api.dart';
import 'package:mtn_ghana_wp/files/model/list_setting_model.dart';

class MyPlayingTuneControllerNew extends GetxController {
  RxBool isLoading = false.obs;
  List<SettingsList> settingsList = [];

  getListSetting() async {
    print("making list setting  api call ");
    isLoading.value = true;
    ListSettingModel model = await listSettingApi("packName");
    settingsList = model.settingsList ?? [];
    isLoading.value = false;
  }
}
