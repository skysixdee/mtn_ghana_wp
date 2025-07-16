import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mtn_ghana_wp/files/api_calls/delete_from_shuffle_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/list_setting_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/shuffle_enable_disable_api.dart';
import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/list_setting_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/snack_bar.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class MyPlayingTuneControllerNew extends GetxController {
  RxBool isLoading = false.obs;
  RxList<SettingsList> settingsList = <SettingsList>[].obs;
  SettingsList? setting;
  RxBool switchingShuffle = false.obs;
  RxBool isShuffleEnable = false.obs;
  getListSetting() async {
    print("making list setting  api call ");
    List<SettingsList> list = [];
    isLoading.value = true;
    ListSettingModel model = await listSettingApi("packName");
    list = model.settingsList ?? [];
    if (list.isNotEmpty) {
      setting = list[0];
      isShuffleEnable.value =
          setting?.isShuffleOn?.toLowerCase() == 'true' ? true : false;
      list.removeAt(0);
    }

    if (setting?.isShuffleOn?.toLowerCase() == 'true') {
      list = list
          .where((itm) => itm.isToneInShuffle?.toLowerCase() == 'true')
          .toList();
    } else {
      list = list
          .where((itm) => itm.isToneInShuffle?.toLowerCase() == 'false')
          .toList();
    }

    settingsList.value = list;
    isLoading.value = false;
  }

  deleteTune(SettingsList setting) async {
    openAlertPopup(
      message: deletePlayingTuneMessageStr,
      secondryBtnTitle: cancelStr,
      onPrimary: () async {
        print("Delete tone name ===== $setting");

        GenericModel model =
            await deleteFromShuffleScApi(setting.contentId ?? '', '1');
        if (model.respCode == 0) {
          settingsList.remove(setting);
        } else {
          snackBar(model.message);
        }
      },
    );
  }

  enabelDispableShuffle() async {
    openAlertPopup(
      message: isShuffleEnable.value
          ? disableShuffleMessageStr
          : doYouWantToEnableShuffleStr,
      primaryBtnTitle: confirmStr,
      secondryBtnTitle: cancelStr,
      onPrimary: () async {
        switchingShuffle.value = true;
        GenericModel model =
            await shuffleEnbleDisableApi(!isShuffleEnable.value);
        if (model.respCode == 0) {
          isShuffleEnable.value = !isShuffleEnable.value;
          getListSetting();
        } else {
          snackBar(model.message);
        }
        switchingShuffle.value = false;
      },
    );
  }
}
