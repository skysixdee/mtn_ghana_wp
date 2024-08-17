import 'package:etisalat/files/api_calls/edit_profile_api.dart';
import 'package:etisalat/files/api_calls/get_profile_detail_api.dart';
import 'package:etisalat/files/model/edit_profile_model.dart';
import 'package:etisalat/files/model/profile_detail_model.dart';
import 'package:etisalat/files/reusable_widgets/custom_snack_bar.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isUpdating = false.obs;
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
    selectedCetegories.clear();
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
    /*
    if (selectedCetegories.length <= 1) {
      selectedCetegories.add(id);
      customSnackBar("sel")
      return;
    }
    */
    bool isContain = selectedCetegories.contains(id);
    isContain ? selectedCetegories.remove(id) : selectedCetegories.add(id);
    print("items are = ${selectedCetegories.length}");
  }

  onConfirmTapButtonAction() async {
    if (selectedCetegories.isEmpty) {
      customSnackBar(selectAtleastOneCategoryStr);
      return;
    }
    enableEdit.value = !enableEdit.value;
    if (enableEdit.value) {
      print("edit taped $selectedCetegories");
    } else {
      isUpdating.value = true;
      EditProfileModel mode = await editProfileApi(selectedCetegories);
      if (mode.statusCode == 'SC0000') {
        getProfileDetails?.categories = '';
        getProfileDetails?.categories = selectedCetegories.join(',');
        customSnackBar(mode.message);
      } else {
        for (var element in (getProfileDetails?.categories ?? '').split(',')) {
          selectedCetegories.add(element);
        }
      }
      isUpdating.value = false;
    }
  }

  onCancelButtonAction() {
    selectedCetegories.clear();
    enableEdit.value = false;
    for (var element in (getProfileDetails?.categories ?? '').split(',')) {
      selectedCetegories.add(element);
    }
  }
}
