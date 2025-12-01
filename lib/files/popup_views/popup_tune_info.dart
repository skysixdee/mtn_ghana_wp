import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget popupToneDetailAndCharge(
    TuneInfo info, SizingInformation si, bool isMusicBox) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment:
        si.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
    children: [
      _tuneImage(info),
      const SizedBox(height: 20),
      _tuneDetail(info, si),
      const SizedBox(height: 10),
      _tuneCharge(si, isMusicBox)
    ],
  );
}

Widget _tuneDetail(TuneInfo info, SizingInformation si) {
  return Column(
    crossAxisAlignment:
        si.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
    children: [
      CustomText(
        title: info.toneName ?? '',
        fontName: FontName.bold,
      ),
      CustomText(
        title: info.artistName ?? '',
        color: grey,
      ),
    ],
  );
}

Widget _tuneImage(
  TuneInfo info,
) {
  return SizedBox(
    height: 180,
    child: customImage(
      imageName: info.localImgName,
      url: info.toneIdpreviewImageUrl,
      cornerRadius: 8,
      fit: BoxFit.fitHeight,
    ),
  );
}

Widget _tuneCharge(SizingInformation si, bool isMusicBox) {
  //String price = StoreManager.other?.tonePrice?.attribute ?? '';
  // String price = StoreManager.other?.mcPriceEnglish?.attribute ?? '';
  String price = isMusicBox ? musicBoxPrice : tuneChargePrice;
  return Column(
    crossAxisAlignment:
        si.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
    children: [
      CustomText(title: isMusicBox ? boxChargeStr : tuneChargeStr),
      CustomText(
        title: price,
        color: grey,
      ),
    ],
  );
}
