import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/player_view/new_player_controller.dart';
import 'package:mtn_ghana_wp/files/popup_views/generic_popup.dart';
import 'package:mtn_ghana_wp/files/popup_views/social_sharing_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

Widget playerShareButton() {
  PlayerController con = Get.find();
  return GenericButton(
      height: 40,
      width: 40,
      radius: 20,
      padding: const EdgeInsets.all(0),
      onTap: () {
        genericPopup(SocialSharingPopup(info: con.info.value));
      },
      leadingIcon: const Icon(
        Icons.share_outlined,
        color: black,
        size: 18,
      )
      // Image.asset(
      //   shareIcon,
      //   height: 30,
      // ),
      );
}
