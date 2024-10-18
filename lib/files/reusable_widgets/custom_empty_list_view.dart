import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';

Widget customEmptyListView({String? message}) {
  return Center(
      child: CustomText(
    title: message ?? listIsEmptyStr,
    fontName: FontName.bold,
    fontSize: 16,
  ));
}
