import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/material.dart';

Widget errorMessageBuilder(
    {String message = '',
    Color color = red,
    double fontSize = 12,
    double top = 10,
    double bottom = 0}) {
  return Visibility(
    visible: message.isNotEmpty,
    child: Padding(
      padding: EdgeInsets.only(top: top, bottom: bottom),
      child: CustomText(
        title: message,
        color: red,
        fontSize: fontSize,
      ),
    ),
  );
  // Obx(
  //   () {
  //     return
  //   },
  // );
}
