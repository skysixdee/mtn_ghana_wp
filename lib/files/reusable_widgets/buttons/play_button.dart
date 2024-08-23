import 'package:etisalat/files/controllers/player_controller.dart';
import 'package:etisalat/files/popup_views/gift_popup_view.dart';
import 'package:flutter/material.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';

Widget playButton(TuneInfo info, {Function()? onTap}) {
  PlayerController pCont = Get.find();
  return ResponsiveBuilder(
    builder: (context, si) {
      return Obx(
        () {
          return GenericButton(
            isStopPlay: false,
            padding: EdgeInsets.zero,
            borderColor: red,
            bgColor: white,
            fontName: si.isMobile ? FontName.regular : FontName.bold,
            leadingIcon: Icon(
              pCont.playingToneId.value == info.toneId
                  ? Icons.pause
                  : Icons.play_arrow_rounded,
              size: pCont.playingToneId.value == info.toneId ? 20 : 22,
            ),
            title: playStr,
            onTap: () {
              pCont.playUrl(info);
              if (onTap != null) {
                onTap();
              }
            },
          );
        },
      );
    },
  );
  //
}
