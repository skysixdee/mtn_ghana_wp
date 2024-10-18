import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';

Widget emptyListWidget({String? message, double? height}) {
  return SizedBox(
    height: height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          title: message ?? listIsEmptyStr,
          fontName: FontName.bold,
          fontSize: 18,
        ),
      ],
    ),
  );
}
