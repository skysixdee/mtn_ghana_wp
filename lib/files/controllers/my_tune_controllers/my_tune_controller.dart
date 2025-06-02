import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/api_calls/delete_mytune_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_my_tune_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_pack_detail_api.dart';
import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/my_tunes_model.dart';
import 'package:mtn_ghana_wp/files/model/pack_detail_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/snack_bar.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:get/get.dart';

import '../../router/route_name.dart';

class MyTuneController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ListToneApk> tuneApkList = <ListToneApk>[].obs;
  RxString message = ''.obs;
  String packName = '';
  getMyTune() async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    if (packName.isEmpty) {
      PackDetailModel packDetailModel = await getPackDetailApi();
      packName = packDetailModel.responseMap?.packStatusDetails?.packName ?? '';
    }
    if (packName.isEmpty) {
      //genericPopover(context, menuList)
      if (Get.context != null) {
        openAlertPopup(
          message: youAreNotAActiveSubscriberStr,
          onPrimary: () {
            Get.context!.goNamed(homeRoute);
          },
        );

        //efwrwe
      }
      isLoading.value = false;
      return;
    }
    message.value = '';
    MyTunesModel model = await getMyTuneApi();
    if (model.statusCode == 'SC0000') {
      tuneApkList.value = model.responseMap?.listToneApk ?? [];
      message.value = tuneApkList.isEmpty ? listIsEmptyStr : '';
    } else {
      message.value = model.message ?? '';
      snackBar(model.message);
    }

    isLoading.value = false;
  }
  // getMyTune() async {
  //   if (isLoading.value) {
  //     return;
  //   }
  //   isLoading.value = true;
  //   if (packName.isEmpty) {
  //     PackDetailModel packDetailModel = await getPackDetailApi();
  //     packName = packDetailModel.responseMap?.packStatusDetails?.packName ?? '';
  //   }
  //   message.value = '';
  //   MyTunesModel model = await getMyTuneApi();
  //   if (model.statusCode == 'SC0000') {
  //     tuneApkList.value = model.responseMap?.listToneApk ?? [];
  //     message.value = tuneApkList.isEmpty ? listIsEmptyStr : '';
  //   } else {
  //     message.value = model.message ?? '';
  //     snackBar(model.message);
  //   }

  //   isLoading.value = false;
  // }

  deleteTune(TuneInfo info, int index) async {
    print("fsddgdfgfdgdfgdf");
    openAlertPopup(
      message: deleteMyTuneMessageStr,
      primaryBtnTitle: confirmStr,
      secondryBtnTitle: cancelStr,
      onPrimary: () async {
        GenericModel model = await deleteMyTuneScApi(info.toneId ?? '', packName);
        if (model.statusCode == 'SC0000') {
          //tuneApkList.removeAt(index);
          print(
              "deleting from list name is ${tuneApkList[index].toneDetails?.first.toneName}");
          //isLoading.value = true;
          tuneApkList.removeAt(index); //toneDetails?.remove(info);
          //isLoading.value = false;
          // for (var element in tuneApkList) {
          //   element.toneDetails?.contains(info);
          // }
        } else {
          snackBar(model.message);
        }
        customPrint("deleteing tune name ${info.toneName}");
      },
    );
  }
}
