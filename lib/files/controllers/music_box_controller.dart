import 'package:mtn_ghana_wp/files/api_calls/get_music_box_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_music_box_content_api.dart';
import 'package:mtn_ghana_wp/files/model/music_box_content_model.dart';
import 'package:mtn_ghana_wp/files/model/music_box_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:get/get.dart';

class MusicBoxController extends GetxController {
  RxBool isLoadingList = false.obs;
  RxBool isLoadingContent = false.obs;
  List<TuneInfo> musicBoxList = [];
  List<TuneInfo> musicBoxContentList = [];
  @override
  void onInit() async {
    customPrint("called");
    super.onInit();
   // getMusicBoxApi();
  }

  getMusicBox() async {
    return 
    isLoadingList.value = true;
    MusicBoxModel model = await getMusicBoxApi();
    musicBoxList = model.responseMap?.musicBoxSearchList ?? [];
    customPrint(
        "SKY==========${model.responseMap?.musicBoxSearchList?.length}");
    isLoadingList.value = false;
  }

  getMusicBoxContent(String type, String code) async {
    return 
    isLoadingContent.value = true;
    MusicBoxContentModel model = await getMusicBoxContentApi(type, code);
    musicBoxContentList = model.responseMap?.searchList ?? [];
    isLoadingContent.value = false;
  }
}
