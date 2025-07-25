import 'package:mtn_ghana_wp/files/api_calls/add_to_shuffle_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/add_to_wishlist_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/delete_music_box_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/delete_mytune_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_my_music_box_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_pack_detail_api.dart';
import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/my_music_box_model.dart';
import 'package:mtn_ghana_wp/files/model/my_tunes_model.dart';
import 'package:mtn_ghana_wp/files/model/pack_detail_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/generic_popover.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/snack_bar.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class MyMusicBoxController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];
  List<TuneInfo>? listToneApk;
  getMyMusicBoxTune() async {
    isLoading.value = true;
    MyTunesModel model = await getMyMusicBoxApi();
    if (model.respCode == 0) {
      tuneList = model.responseMap?.toneList ?? [];
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
        //PackDetailModel packDetailModel = await getPackDetailApi();
        //if (packDetailModel.respCode == 0) {
        GenericModel genericModel = await deleteMusicBoxApi(info.toneId ?? '');
        info.isDeleting.value = false;
        if (genericModel.respCode == 0) {
          snackBar(genericModel.message);
          isLoading.value = true;
          await Future.delayed(const Duration(milliseconds: 10));
          tuneList.remove(info);
          isLoading.value = false;
        } else {
          snackBar(genericModel.message);
        }
        // } else {
        //   snackBar(packDetailModel.message);
        //   info.isDeleting.value = false;
        // }
      },
    );
  }
}
