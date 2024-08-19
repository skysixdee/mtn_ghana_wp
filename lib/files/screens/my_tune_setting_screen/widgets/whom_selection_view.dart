import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';

Widget whomSelectionView() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        title: whomYouWantToPlayItStr,
        fontName: FontName.bold,
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.radio_button_checked, size: 16),
              CustomText(
                title: allCallerStr,
              )
            ],
          ),
          const SizedBox(width: 40),
          Row(
            children: [
              const Icon(
                Icons.radio_button_off,
                size: 16,
              ),
              CustomText(title: specialCallerStr)
            ],
          )
        ],
      ),
    ],
  );
}
