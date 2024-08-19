import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';

Widget customEmptyListView({String? message}) {
  return Center(
      child: CustomText(
    title: message ?? listIsEmptyStr,
    fontName: FontName.bold,
    fontSize: 16,
  ));
}
