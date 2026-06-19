import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mtn_ghana_wp/files/api_calls/category_search_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_app_setting.dart';
import 'package:mtn_ghana_wp/files/model/advanced_search_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/screens/mood_detect/mood_chip_model.dart';
import 'package:mtn_ghana_wp/files/screens/mood_detect/mood_list_model.dart';
import 'package:mtn_ghana_wp/files/screens/mood_detect/mood_service.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';

class MoodsController extends GetxController {
  RxBool isLoadingModels = false.obs;
  RxBool modelsReady = false.obs;
  RxBool isMoodTapped = false.obs;
  RxBool isLoadingTunes = false.obs;
  RxString loadError = ''.obs;
  RxString mood = "".obs;
  Rx<Uint8List?> imageBytes = Rx<Uint8List?>(null);
  RxList<TuneInfo> moodList = <TuneInfo>[].obs;
  RxList<MoodChipModel> moodChipList = <MoodChipModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    getMoodChipList();
  }

  loadModelFunc() async {
    try {
      await MoodService.loadModels();
      modelsReady.value = true;
    } catch (e) {
      loadError.value = e.toString();
      print("errro is $e");
    } finally {
      isLoadingModels.value = false;
    }
  }

  getMoodChipList() async {
    if (StoreManager.other == null) {
      await getAppSettingApi();
    }
    List<MoodChipModel> moodChipListTemp = [];
    String moodChipListStr = StoreManager.isEnglish
        ? (StoreManager.other?.moodListEnglish?.attribute ?? "")
        : StoreManager.other?.moodListEnglish?.attribute ?? "";
    print("mood string $moodChipListStr");
    if (moodChipListStr.isEmpty) return;
    for (var itm in moodChipListStr.split("|")) {
      moodChipListTemp.add(MoodChipModel(
          id: itm.split(",")[0],
          title: itm.split(",")[1],
          image: itm.split(",")[2]));
      print(" ======= ${itm.split(",")[1]}");
    }
    moodChipList.assignAll(moodChipListTemp);
  }

  getMoodListOnChipTap(String mood, String catId) async {
    isMoodTapped.value = true;
    getMoodToneList(mood, catId: catId);
  }

  getMoodToneList(String mood, {String catId = "46"}) async {
    moodList.clear();
    isLoadingTunes.value = true;
    // String url =
    //     "$baseUrl/apigw/Middleware/api/adapter/v1/crbt/search-tone?language=English&sortBy=Order_By&alignBy=ASC&searchLanguage=English?searchKey=$mood&genreDetailUrl&perPageCount=20&categoryId=$catId&pageNo=0";
    // Map<String, dynamic> jsonResp = await NetworkManager().get(url);
//MoodsListModel model = MoodsListModel.fromJson(jsonResp);
    AdvancedSearchModal model = await categorySearchApi(catId);

    moodList.assignAll(model.responseMap?.toneList ?? []);
    isLoadingTunes.value = false;
  }

  pickImage() async {
    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // optional compression
    );
    print("image $image");
    if (image != null) {
      final Uint8List bytes = await image.readAsBytes();
      imageBytes.value = bytes;
      final result = await MoodService.detectMood(bytes);
      mood.value = result['mood'] ?? 'unknown';
      getMoodToneList(mood.value);
    }
  }
}
