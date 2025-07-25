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
import 'package:mtn_ghana_wp/files/router/router.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:get/get.dart';

import '../../router/route_name.dart';

class MyTuneController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<TuneInfo> tuneApkList = <TuneInfo>[].obs;
  RxString message = ''.obs;
  String packName = '';
  getMyTune() async {
    if (isLoading.value) {
      return;
    }

    isLoading.value = true;
    if (packName.isEmpty) {
      try {
        PackDetailModel packDetailModel = await getPackDetailApi();
        packName = packDetailModel.offers?.first.offerName ?? '';
      } catch (e) {
        print("error is $e");
      }
    }
    print("sky test");
    try {
      if (packName.isEmpty) {
        //genericPopover(context, menuList)
        //if (Get.context != null) {
        openAlertPopup(
          message: youAreNotAActiveSubscriberStr,
          onPrimary: () {
            router.goNamed(homeRoute);
          },
        );

        //efwrwe
        //}
        isLoading.value = false;
        return;
      }
    } catch (e) {
      print("erro is ==$e");
    }

    message.value = '';
    MyTunesModel model = await getMyTuneApi();
    print("Sky ==312==========${model.responseMap?.toneList?.length}");
    if (model.respCode == 0) {
      final list = model.responseMap?.toneList ?? [];

      tuneApkList.value =
          list.where((itm) => itm.isContentPackage == '0').toList();
      message.value = tuneApkList.isEmpty ? listIsEmptyStr : '';
    } else {
      message.value = model.message ?? '';
      snackBar(model.message);
    }

    isLoading.value = false;
  }

  deleteTune(TuneInfo info, int index) async {
    print("fsddgdfgfdgdfgdf");
    openAlertPopup(
      message: deleteMyTuneMessageStr,
      primaryBtnTitle: confirmStr,
      secondryBtnTitle: cancelStr,
      onPrimary: () async {
        GenericModel model =
            await deleteMyTuneScApi(info.toneId ?? '', packName);
        if (model.respCode == 0) {
          //tuneApkList.removeAt(index);
          print("deleting from list name is ${tuneApkList[index].toneName}");
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
