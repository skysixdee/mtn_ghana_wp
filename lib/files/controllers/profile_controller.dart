import 'package:flutter/widgets.dart';
import 'package:mtn_ghana_wp/files/api_calls/delete_mytune_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/edit_profile_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_pack_detail_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_profile_detail_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/set_tone_api.dart';
import 'package:mtn_ghana_wp/files/model/edit_profile_model.dart';
import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/pack_detail_model.dart';
import 'package:mtn_ghana_wp/files/model/profile_detail_model.dart';
import 'package:mtn_ghana_wp/files/popup_views/subscription_plans_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/snack_bar.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSubscribing = false.obs;
  RxBool isUpdating = false.obs;
  RxList<String> selectedCetegories = <String>[].obs;
  RxBool enableEdit = false.obs;
  GetProfileDetails? getProfileDetails;
  PackStatusDetails? packStatusDetails;
  @override
  void onInit() {
    super.onInit();
    //getProfileDetail();
  }

  getProfileDetail() async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    PackDetailModel model = await getPackDetailApi();
    packStatusDetails = model.responseMap?.packStatusDetails;
    ProfileDetailModel info = await getProfileDetailApi();
    customPrint("inf111o ===== $info");
    String va = info.responseMap?.getProfileDetails?.categories ?? '';
    getProfileDetails = info.responseMap?.getProfileDetails;
    customPrint("info ===== $info");
    selectedCetegories.clear();
    for (var element in va.split(',')) {
      selectedCetegories.add(element);
      customPrint("element ===== $element");
    }
    isLoading.value = false;
  }

  updateChoice(String id) {
    if (!enableEdit.value) {
      return;
    }
    /*
    if (selectedCetegories.length <= 1) {
      selectedCetegories.add(id);
      customSnackBar("sel")
      return;
    }
    */
    bool isContain = selectedCetegories.contains(id);
    isContain ? selectedCetegories.remove(id) : selectedCetegories.add(id);
    customPrint("items are = ${selectedCetegories.length}");
  }

  onConfirmTapButtonAction() async {
    if (selectedCetegories.isEmpty) {
      snackBar(selectAtleastOneCategoryStr);
      return;
    }

    enableEdit.value = !enableEdit.value;

    if (enableEdit.value) {
      customPrint("edit taped $selectedCetegories");
    } else {
      if (selectedCetegories.join(',') == getProfileDetails?.categories) {
        snackBar(noChangeToUpdateStr);
        return;
      }
      isUpdating.value = true;
      EditProfileModel mode = await editProfileApi(selectedCetegories);
      if (mode.statusCode == 'SC0000') {
        getProfileDetails?.categories = '';
        getProfileDetails?.categories = selectedCetegories.join(',');
        snackBar(mode.message);
      } else {
        for (var element in (getProfileDetails?.categories ?? '').split(',')) {
          selectedCetegories.add(element);
        }
      }
      isUpdating.value = false;
    }
  }

  onCancelButtonAction() {
    selectedCetegories.clear();
    enableEdit.value = false;
    for (var element in (getProfileDetails?.categories ?? '').split(',')) {
      selectedCetegories.add(element);
    }
  }
  
  subscribeButtonAction() async {
    Get.dialog(Center(
      child: SubscriptionPlansView(
        onConfirm: (item) async {
          isSubscribing.value = true;
          String defaultToneId = '';//default tone from setting api
              //StoreManager.other?.defaultTone?.attribute ?? '';

          GenericModel model =
              await setToneApi(defaultToneId, '', packName: item.title);
          if (model.statusCode == 'SC0000') {
            getProfileDetail();
          } else {
            snackBar(model.message);
          }

          isSubscribing.value = false;
          print("selected item is ${item.value}");
          print("selected item is ${item.title}");
        },
      ),
    ));
    print("subscribeButtonAction");
  }

  unSubscribeButtonAction() async {
    openAlertPopup(
      message: unSubscribeMessageStr,
      primaryBtnTitle: confirmStr,
      secondryBtnTitle: cancelStr,
      onPrimary: () async{
        isSubscribing.value = true;
    GenericModel model =
        await deleteMyTuneApi("", packStatusDetails?.packName ?? '');
    if (model.statusCode == 'SC0000') {
      openAlertPopup(message: unSubscribeSuccessfulMessageStr,
      onPrimary: () {
        getProfileDetail();
      },);
      
    } else {
      snackBar(model.message);
    }

    isSubscribing.value = false;
      },
    );
    
    print("unSubscribeButtonAction");
  }
}
