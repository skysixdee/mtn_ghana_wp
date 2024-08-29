import 'package:etisalat/files/controllers/buy_tune_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/google_tag_manager/google_tag_manager.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/popup_views/buy_popup_view.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/screens/authentication_screen/login_otp_popup.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
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
