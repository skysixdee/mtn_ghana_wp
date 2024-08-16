import 'package:etisalat/files/api_calls/get_profile_detail_api.dart';
import 'package:etisalat/files/model/profile_detail_model.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<String> selectedCetegories = <String>[].obs;
  RxBool enableEdit = false.obs;
  GetProfileDetails? getProfileDetails;
  @override
  void onInit() {
    super.onInit();
    getProfileDetail();
  }

  getProfileDetail() async {
    isLoading.value = true;
    ProfileDetailModel info = await getProfileDetailApi();
    print("inf111o ===== $info");
    String va = info.responseMap?.getProfileDetails?.categories ?? '';
    getProfileDetails = info.responseMap?.getProfileDetails;
    print("info ===== $info");
    for (var element in va.split(',')) {
      selectedCetegories.add(element);
      print("element ===== $element");
    }
    isLoading.value = false;
  }

  updateChoice(String id) {
    if (!enableEdit.value) {
      return;
    }
    selectedCetegories.contains(id);
    bool isContain = selectedCetegories.contains(id);

    isContain
        // ignore: collection_methods_unrelated_type
        ? selectedCetegories.remove(id)
        : selectedCetegories.add(id);
    print("items are = ${selectedCetegories.length}");
  }

  onConfirmTapButtonAction() {
    enableEdit.value = !enableEdit.value;
    // if (enableEdit.value) {
    // } else {}
  }

  onCancelButtonAction() {
    selectedCetegories.clear();
    enableEdit.value = false;
    for (var element in (getProfileDetails?.categories ?? '').split(',')) {
      selectedCetegories.add(element);
    }
  }
}
