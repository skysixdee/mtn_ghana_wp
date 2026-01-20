import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_reward_point_api.dart';
import 'package:mtn_ghana_wp/files/model/get_reward_point_model.dart';

class RewardPointController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<GetRewardPointModel> resp = GetRewardPointModel().obs;
  getRewardPoint() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    try {
      GetRewardPointModel model = await getRewardPointApi();
      resp.value = model;
    } catch (e) {
      print("catch is ${e}");
    }
    GetRewardPointModel model = await getRewardPointApi();
    resp.value = model;
    isLoading.value = false;
  }
}
