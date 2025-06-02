import 'package:mtn_ghana_wp/files/api_calls/add_to_shuffle_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/add_to_wishlist_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/delete_mytune_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_my_music_box_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_pack_detail_api.dart';
import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/my_music_box_model.dart';
import 'package:mtn_ghana_wp/files/model/pack_detail_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/generic_popover.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/snack_bar.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class MyMusicBoxController extends GetxController {
  RxBool isLoading = false.obs;
  List<ListToneApk> tuneList = [];
  List<ListToneApk>? listToneApk;
  getMyMusicBoxTune() async {
    isLoading.value = true;
    MyMusicBoxModel model = await getMyMusicBoxApi();
    if (model.statusCode == 'SC0000') {
      tuneList = model.responseMap?.listToneApk?? [];
    }

    isLoading.value = false;
  }

  addToShuffle(String toneId) async {
    addToShuffleScApi(toneId);
  }

  deleteMyMusicBox(TuneInfo info) async {
    openAlertPopup(
      message: areYouSureWantToDeleteThisMusicBoxStr,
      secondryBtnTitle: cancelStr,
      primaryBtnTitle: confirmStr,
      onPrimary: () async {
        info.isDeleting.value = true;
        print("delete music box api perform here");
        PackDetailModel packDetailModel = await getPackDetailApi();
        if (packDetailModel.statusCode == 'SC0000') {
          GenericModel genericModel = await deleteMyTuneScApi(info.toneId ?? '',
              packDetailModel.responseMap?.packStatusDetails?.packName ?? '');
          info.isDeleting.value = false;
          if (genericModel.statusCode == 'SC0000') {
            snackBar(packDetailModel.message);
            isLoading.value = true;
            await Future.delayed(const Duration(milliseconds: 10));
            tuneList.remove(info);
            isLoading.value = false;
          } else {
            snackBar(packDetailModel.message);
          }
        } else {
          snackBar(packDetailModel.message);
          info.isDeleting.value = false;
        }
      },
    );
  }
}
