import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/popup_views/buy_popup_view.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget buyButton(TuneInfo info) {
  return ResponsiveBuilder(
    builder: (context, si) {
      return GenericButton(
        title: buyStr,
        fontName: si.isMobile ? FontName.regular : FontName.bold,
        leadingIcon: const Icon(Icons.card_travel, size: 16),
        bgColor: yellow,
        onTap: () {
          Get.dialog(BuyPopupView(info: info));
        },
      );
    },
  );
}
