import 'package:mtn_ghana_wp/files/controllers/buy_tune_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/google_tag_manager/google_tag_manager.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/popup_views/buy_popup_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/screens/authentication_screen/login_otp_popup.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget buyButton(TuneInfo info,
    {EdgeInsetsGeometry? padding, bool isMusicBox = false}) {
  BuyTuneController bCont = Get.find();
  buyClickEvent(info);
  return ResponsiveBuilder(
    builder: (context, si) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: GenericButton(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 2),
          title: buyStr,
          fontName: si.isMobile ? FontName.regular : FontName.bold,
          leadingIcon: const Icon(Icons.card_travel, size: 16),
          bgColor: yellow,
          onTap: () {
            bCont.resetValue();
            Get.dialog(Obx(
              () {
                return bCont.displayOptScreen.value
                    ? LoginOtpPopup(
                        msisdn: bCont.msisdn,
                        info: info,
                      )
                    : BuyPopupView(
                        info: info,
                        isMusicBox: isMusicBox,
                      );
              },
            ));
          },
        ),
      );
    },
  );
}
