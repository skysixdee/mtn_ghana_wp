import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/api_calls/add_to_wishlist_api.dart';
import 'package:mtn_ghana_wp/files/player_view/new_player_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

playerAddToWishListButton() {
  PlayerController con = Get.find();
  return GenericButton(
    height: 40,
    width: 40,
    radius: 20,
    padding: const EdgeInsets.all(0),
    onTap: () {
      //addToWishlistApi(con.info.value);
      if (StoreManager.isLoggedIn) {
        addToWishlistApi(con.info.value);
      } else {
        openAlertPopup(
          message: thisFeatureIsAvailableForLoggedinStr,
          textAlign: TextAlign.center,
        );
      }

      print("add to wishlist api call here");
    },
    leadingIcon: Image.asset(
      likeIcon,
      height: 30,
      color: black,
    ),
  );
}
