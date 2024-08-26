import 'package:etisalat/files/api_calls/send_gift_api.dart';
import 'package:etisalat/files/model/generic_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/custom_alert_popup.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:get/get.dart';

class GiftController extends GetxController {
  RxBool isLoading = false.obs;
  RxString messsage = ''.obs;
  String bPrtyMsisdn = '';
  Function()? onDismiss;
  onConfirmButtonAction(TuneInfo info) async {
    messsage.value = '';
    if (bPrtyMsisdn.isEmpty) {
      messsage.value = enterValidMsisdnStr;
      return;
    }
    if (bPrtyMsisdn.length < msisdnLength) {
      messsage.value = enterFriendMobileNumberStr;
      return;
    }
    sendGift(info);
  }

  sendGift(TuneInfo info) async {
    isLoading.value = true;
    GenericModel model =
        await sendGiftfApi(bPrtyMsisdn, info.toneId ?? '', info.toneName ?? '');
    if (model.statusCode == 'SC0000') {
      openAlertPopup(
        message: model.message ?? '',
        onPrimary: () {
          if (onDismiss != null) {
            onDismiss!();
          }
        },
      );
    } else {
      messsage.value = model.message ?? someThingWentWrongStr;
    }
    isLoading.value = false;
  }

  updateMsisdn(String value) {
    messsage.value = '';
    bPrtyMsisdn = value;
  }
}
