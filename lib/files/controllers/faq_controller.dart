import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/api_calls/faq_api.dart';
import 'package:mtn_ghana_wp/files/model/faq_model.dart';

class FaqController extends GetxController {
  var isExpanded = <int, bool>{}.obs;
  var faqData = FaqModal().obs;
  var isLoading = true.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFaqData();
  }

  void fetchFaqData() async {
    try {
      isLoading.value = true;
      faqData.value = await FaqApi();
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