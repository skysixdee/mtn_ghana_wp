import 'package:mtn_ghana_wp/files/api_calls/get_music_box_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_music_box_content_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_my_tune_api.dart';
import 'package:mtn_ghana_wp/files/model/music_box_content_model.dart';
import 'package:mtn_ghana_wp/files/model/music_box_mw_model.dart';
import 'package:mtn_ghana_wp/files/model/music_box_sc_model.dart';
import 'package:mtn_ghana_wp/files/model/my_tunes_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:get/get.dart';

class MusicBoxController extends GetxController {
  RxBool isLoadingList = false.obs;
  RxBool isLoadingContent = false.obs;
  //List<ListToneApk> musicBoxList = [];
  List<MusicBoxList> musicBoxList = [];
  List<TuneInfo> musicBoxContentList = [];
  @override
  void onInit() async {
    customPrint("called");
    super.onInit();
    //getMusicBoxApi();
    print("-------music box api------------------------");
  }

  getMusicBoxx() async {
    //return
    isLoadingList.value = true;
    // MusicBoxMwModel model = await getMusicBoxApi();
    // musicBoxList = model.responseMap?.musicBoxSearchList ?? [];
    // customPrint("GOKULHARI==========${model.responseMap?.musicBoxSearchList?.length}");

    MusicBoxScModel model = await getMusicBoxScApi();
    musicBoxList = model.musicBoxList ?? [];
    print("MusicboxList===============${musicBoxList}");
    isLoadingList.value = false;
  }

  getMusicBoxContent(String id) async {
    //return
    isLoadingContent.value = true;
    MusicBoxContentModel model = await getMusicBoxContentApi(id);
    musicBoxContentList = model.responseMap?.tonelist ?? [];
    isLoadingContent.value = false;
  }
}
