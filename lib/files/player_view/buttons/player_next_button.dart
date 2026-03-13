import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/player_view/new_player_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

Widget playerNextbutton() {
  PlayerController con = Get.find();
  return GenericButton(
    width: 42,
    height: 42,
    radius: 21,
    leadingIcon: const Icon(
      Icons.skip_next_rounded,
      size: 18,
      color: black,
    ),
    padding: const EdgeInsets.all(0),
    onTap: () => con.nextButton(),
  );
}
