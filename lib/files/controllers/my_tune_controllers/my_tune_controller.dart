import 'package:etisalat/files/api_calls/delete_mytune_api.dart';
import 'package:etisalat/files/api_calls/get_my_tune_api.dart';
import 'package:etisalat/files/api_calls/get_pack_detail_api.dart';
import 'package:etisalat/files/model/generic_model.dart';
import 'package:etisalat/files/model/my_tunes_model.dart';
import 'package:etisalat/files/model/pack_detail_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/custom_alert_popup.dart';
import 'package:etisalat/files/reusable_widgets/custom_snack_bar.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:get/get.dart';

class MyTuneController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ListToneApk> tuneApkList = <ListToneApk>[].obs;
  RxString message = ''.obs;
  String packName = '';
  getMyTune() async {
    isLoading.value = true;
    if (packName.isEmpty) {
      PackDetailModel packDetailModel = await getPackDetailApi();
      packName = packDetailModel.responseMap?.packStatusDetails?.packName ?? '';
    }
    message.value = '';
    MyTunesModel model = await getMyTuneApi();
    if (model.statusCode == 'SC0000') {
      tuneApkList.value = model.responseMap?.listToneApk ?? [];
      message.value = tuneApkList.isEmpty ? listIsEmptyStr : '';
    } else {
      message.value = model.message ?? '';
      customSnackBar(model.message);
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
        GenericModel model = await deleteMyTuneApi(info.toneId ?? '', packName);
        if (model.statusCode == 'SC0000') {
          tuneApkList.removeAt(index);
          // for (var element in tuneApkList) {
          //   element.toneDetails?.contains(info);
          // }
        } else {
          customSnackBar(model.message);
        }
        customPrint("deleteing tune name ${info.toneName}");
      },
    );
  }
}
