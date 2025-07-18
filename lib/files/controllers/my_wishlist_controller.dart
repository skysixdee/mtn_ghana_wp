import 'package:mtn_ghana_wp/files/api_calls/delete_from_wishlist_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_wishlist_api.dart';
import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/model/wishlist_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/snack_bar.dart';
import 'package:get/get.dart';

class MyWishlistController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<TuneInfo> tuneList = <TuneInfo>[].obs;
  getWishlist() async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    try {
      print("GOkul");
      WishlistModel model = await getWishlistScApi();
      print("Vivek");

      tuneList.value = model.wishlist ?? [];
      print("Get Wishlist============= ${tuneList}");
    } catch (e, stackTrace) {
      print("Error in getWishlist: $e");
      print("StackTrace: $stackTrace");
      snackBar("Something went wrong while fetching wishlist");
    } finally {
      isLoading.value = false;
    }
  }
  //   print("GOkul");
  //   WishlistModel model = await getWishlistScApi();
  //   print("Vivek");
  //   tuneList.value = model.wishlist ?? [];

  //   print("Get Wishlist============= ${tuneList.value}");
  //   //model.responseMap?.toneDetailsList ?? [];
  //   isLoading.value = false;
  // }

  deleteFromWishlist(TuneInfo info) async {
    customPrint("delete ${info.toneName}");
    GenericModel model = await deleteFromWishlistApi(info);
    if (model.respCode == 0) {
      String ms = "${info.toneName} deleted " + "${model.message}fully";
      tuneList.remove(info);
      snackBar(ms);
    } else {
      snackBar(model.message);
    }
  }
}
