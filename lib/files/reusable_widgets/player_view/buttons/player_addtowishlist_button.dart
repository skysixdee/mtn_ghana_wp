import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/new_player_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';

playerAddToWishListButton() {
  PlayerController con = Get.find();
  return GenericButton(
    height: 40,
    width: 40,
    radius: 20,
    padding: const EdgeInsets.all(0),
    onTap: () {
      //addToWishlistApi(con.info.value);
      print("add to wishlist api call here");
    },
    leadingIcon: Image.asset(
      likeIcon,
      height: 30,
      color: black,
    ),
  );
}
