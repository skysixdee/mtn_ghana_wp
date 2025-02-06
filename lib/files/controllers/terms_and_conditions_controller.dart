import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/api_calls/terms_and_conditions_api.dart';
import 'package:mtn_ghana_wp/files/model/terms_and_conditions_model.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';


class TermsAndConditionsController extends GetxController {
  var isExpanded = <int, bool>{}.obs;
  var termsData = TermsAndConditionsModel().obs;
  var isLoading = true.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTermsData();
  }

  void fetchTermsData() async {
    try {
      isLoading.value = true;
      termsData.value = await termsAndConditionsApi();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
    }
  }

  void toggleExpansion(int index) {
    isExpanded[index] = !(isExpanded[index] ?? false);
  }
}