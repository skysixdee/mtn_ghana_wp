import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/new_player_controller.dart';
import 'package:mtn_ghana_wp/files/enums/my_player_state.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/minimized_player_view.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

Widget playerPlayPauseButton() {
  PlayerController con = Get.find();
  return GenericButton(
      width: 46,
      height: 46,
      borderColor: black,
      leadingIcon: Obx(
        () {
          return playIconLoadBasedOnState(con.myPlayerState.value);
        },
      ),
      radius: 23,
      padding: const EdgeInsets.all(0),
      onTap: con.myPlayerState.value == MyPlayerState.loading
          ? null
          : () {
              con.playPause();
            });
}
