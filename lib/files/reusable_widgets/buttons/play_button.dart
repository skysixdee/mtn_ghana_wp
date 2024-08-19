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
  return ResponsiveBuilder(
    builder: (context, si) {
      return GenericButton(
        borderColor: red,
        bgColor: white,
        fontName: si.isMobile ? FontName.regular : FontName.bold,
        leadingIcon: const Icon(Icons.play_arrow_rounded),
        title: playStr,
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
      );
    },
  );
  //
}
