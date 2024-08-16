import 'package:etisalat/files/api_calls/get_wishlist_api.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/model/wishlist_model.dart';
import 'package:get/get.dart';

class MyWishlistController extends GetxController {
  RxBool isLoading = false.obs;
  List<TuneInfo> tuneList = [];
  getWishlist() async {
    isLoading.value = true;
    WishlistModel model = await getWishlistApi();
    tuneList = model.responseMap?.toneDetailsList ?? [];
    isLoading.value = false;
  }
}
