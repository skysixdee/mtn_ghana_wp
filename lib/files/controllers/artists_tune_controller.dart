import 'package:etisalat/files/api_calls/get_artist_tunes_list_api.dart';
import 'package:etisalat/files/model/artist_tune_list_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:get/get.dart';

class ArtistsTuneController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = <TuneInfo>[].obs;

  getArtistsTune(String key) async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    ArtistTuneListModel model = await getArtistTuneListApi(key);
    tuneList = model.responseMap?.searchList ?? [];
    isLoading.value = false;
  }
}
