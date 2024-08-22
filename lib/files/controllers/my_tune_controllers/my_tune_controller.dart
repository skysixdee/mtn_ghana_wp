import 'package:etisalat/files/api_calls/get_my_tune_api.dart';
import 'package:etisalat/files/model/my_tunes_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/custom_alert_popup.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:get/get.dart';

class MyTuneController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];
  RxString message = ''.obs;
  getMyTune() async {
    isLoading.value = true;
    message.value = '';
    MyTunesModel model = await getMyTuneApi();
    if (model.statusCode == 'SC0000') {
      tuneList = model.responseMap?.listToneApk?.first.toneDetails ?? [];
      message.value = tuneList.isEmpty ? listIsEmptyStr : '';
    } else {
      message.value = model.message ?? '';
    }

    isLoading.value = false;
  }

  deleteTune(TuneInfo info) async {
    print("fsddgdfgfdgdfgdf");
    openAlertPopup(
      message: deleteMyTuneMessageStr,
      primaryBtnTitle: confirmStr,
      secondryBtnTitle: cancelStr,
      onPrimary: () {
        customPrint("deleteing tune name ${info.toneName}");
      },
    );
  }
}
