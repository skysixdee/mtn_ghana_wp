import 'dart:ui';

import 'package:etisalat/files/api_calls/delete_blacklist_api.dart';
import 'package:etisalat/files/api_calls/get_blacklist_api.dart';
import 'package:etisalat/files/model/blackList_model.dart';
import 'package:etisalat/files/model/generic_model.dart';
import 'package:etisalat/files/reusable_widgets/custom_alert_popup.dart';
import 'package:etisalat/files/reusable_widgets/snack_bar.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:get/get.dart';

class BlacklistController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<BPartyDetailsList> list = <BPartyDetailsList>[].obs;
  getList() async {
    isLoading.value = true;
    ViewBlackListModel model = await getBlackListApi();
    list.value = model.responseMap?.bPartyDetailsList ?? [];
    isLoading.value = false;
  }

  deleteBlackList(BPartyDetailsList info) async {
    openAlertPopup(
      message: deleteBlackListConfirmMessageStr,
      secondryBtnTitle: cancelStr,
      primaryBtnTitle: confirmStr,
      onPrimary: () {
        print("delete balcklist api perform here");
        _deleteApiCall(info);
      },
    );
  }

  _deleteApiCall(BPartyDetailsList info) async {
    info.isDeleting.value = true;
    GenericModel model = await deleteBlackListApi(info.bPartyMsisdn ?? '');
    if (model.statusCode == 'SC0000') {
      list.remove(info);
      snackBar(model.message);
    } else {
      snackBar(model.message);
    }
    info.isDeleting.value = false;
  }
}
