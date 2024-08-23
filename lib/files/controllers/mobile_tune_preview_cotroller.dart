import 'package:etisalat/files/controllers/player_controller.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:get/get.dart';

class MobileTunePreviewCotroller extends GetxController {
  RxString tuneName = ''.obs;
  RxString artistName = ''.obs;
  RxString imageName = ''.obs;
  RxBool isPlaying = false.obs;
  RxBool enablePreviousButton = false.obs;
  RxBool enableNextButton = false.obs;
  List<TuneInfo> tuneList = <TuneInfo>[].obs;
  int currentIndex = 0;
  Rx<TuneInfo> currentTuneDetail = TuneInfo().obs;

  customInit(int currentIndex, List<TuneInfo> tuneList) {
    this.currentIndex = currentIndex;
    this.tuneList = tuneList;
    TuneInfo inf = tuneList[currentIndex];
    currentTuneDetail.value = inf;
    tuneName.value = inf.toneName ?? '';
    artistName.value = inf.artistName ?? '';
    imageName.value = inf.toneIdpreviewImageUrl ?? inf.previewImageUrl ?? '';

    print("current $currentIndex");
    print("len ${tuneList.length}");
    enablePreviousButton.value = tuneList.length > 1 && currentIndex != 0;
    enableNextButton.value = currentIndex != (tuneList.length - 1);
  }

  previoustButtonTap(PlayerController con) {
    if (currentIndex <= 0) {
      return;
    }

    currentIndex -= 1;

    enablePreviousButton.value = tuneList.length > 1 && currentIndex != 0;
    enableNextButton.value =
        tuneList.length > 1 && currentIndex != tuneList.length;
    print("current index  = $currentIndex");
    //enablePreviousButton.value = tuneList.length;
    enableNextButton.value = currentIndex != tuneList.length;
    TuneInfo inf = tuneList[currentIndex];
    currentTuneDetail.value = inf;
    tuneName.value = inf.toneName ?? '';
    artistName.value = inf.artistName ?? '';
    imageName.value = inf.toneIdpreviewImageUrl ?? inf.previewImageUrl ?? '';
    con.playUrl(currentTuneDetail.value);
  }

  nextButtonTap(PlayerController con) {
    if (currentIndex >= (tuneList.length - 1)) {
      return;
    }
    currentIndex += 1;

    print("currnt$currentIndex");
    print("length ${tuneList.length}");

    enablePreviousButton.value = true;
    enableNextButton.value = currentIndex != (tuneList.length - 1);
    print("current index  = $currentIndex");
    TuneInfo inf = tuneList[currentIndex];
    currentTuneDetail.value = inf;
    tuneName.value = inf.toneName ?? '';
    artistName.value = inf.artistName ?? '';
    imageName.value = inf.toneIdpreviewImageUrl ?? inf.previewImageUrl ?? '';
    con.playUrl(currentTuneDetail.value);
  }
}
