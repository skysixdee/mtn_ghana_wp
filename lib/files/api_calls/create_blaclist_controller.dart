import 'package:etisalat/files/api_calls/create_blecklist_api.dart';
import 'package:etisalat/files/model/create_blcklist_model.dart';
import 'package:etisalat/files/model/generic_model.dart';
import 'package:etisalat/files/reusable_widgets/custom_alert_popup.dart';
import 'package:etisalat/files/reusable_widgets/snack_bar.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBlaclistController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<CreateBlacklistModel> memebrList = <CreateBlacklistModel>[].obs;

  addToList(CreateBlacklistModel info) {
    memebrList.add(info);
    print("total items are ${memebrList.length}");
  }

  deleteMember(CreateBlacklistModel info) {
    memebrList.remove(info);
  }

  onConfirmButtonAction() async {
    if (memebrList.isEmpty) {
      openAlertPopup(message: listIsEmptyStr);
      return;
    }
    isLoading.value = true;
    GenericModel model = await createBlackListApi(memebrList);
    if (model.statusCode == 'SC0000') {
      memebrList.clear();
    }
    snackBar(model.message);
    isLoading.value = false;
  }
}
