import 'package:etisalat/files/api_calls/delete_from_wishlist_api.dart';
import 'package:etisalat/files/api_calls/get_wishlist_api.dart';
import 'package:etisalat/files/model/generic_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/model/wishlist_model.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/reusable_widgets/custom_snack_bar.dart';
import 'package:get/get.dart';

class MyWishlistController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<TuneInfo> tuneList = <TuneInfo>[].obs;
  getWishlist() async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    WishlistModel model = await getWishlistApi();
    tuneList.value = model.responseMap?.toneDetailsList ?? [];
    isLoading.value = false;
  }

  deleteFromWishlist(TuneInfo info) async {
    customPrint("delete ${info.toneName}");
    GenericModel model = await deleteFromWishlistApi(info);
    if (model.statusCode == "SC0000") {
      String ms = "${info.toneName} deleted " + "${model.message}fully";
      customSnackBar(ms);
    } else {
      customSnackBar(model.message);
    }
    tuneList.remove(info);
  }
}
