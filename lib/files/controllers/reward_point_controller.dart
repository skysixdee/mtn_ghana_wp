import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_reward_point_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_top_leader_board_api.dart';
import 'package:mtn_ghana_wp/files/model/get_reward_point_model.dart';
import 'package:mtn_ghana_wp/files/model/get_top_leader_board_model.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';

class RewardPointController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoadingLeaderBoard = false.obs;
  Rx<GetRewardPointModel> resp = GetRewardPointModel().obs;
  RxList leaderBoardList = <PointsList>[].obs;

  @override
  void onInit() {
    super.onInit();
    getLeaderBoard();
  }

  getRewardPoint() async {
    if (!StoreManager.isLoggedIn) {
      return;
    }
    if (isLoading.value) {
      print("user is already loading data");
      return;
    }

    if (resp.value.respCode == 0) {
      print("Data is already loaded");
      return;
    }
    isLoading.value = true;
    try {
      GetRewardPointModel model = await getRewardPointApi();
      resp.value = model;
    } catch (e) {
      print("catch is ${e}");
    }

    isLoading.value = false;
  }

  getLeaderBoard() async {
    if (isLoadingLeaderBoard.value) {
      print("Already loading leaderboard data");
      return;
    }
    isLoadingLeaderBoard.value = true;

    GetLeaderBoardModel model = await getTopLeaderBoardApi();
    leaderBoardList.value = model.pointsList ?? [];
    isLoadingLeaderBoard.value = false;
  }
}
