import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';

Widget whenPlayButton() {
  return GenericButton(
    padding: const EdgeInsets.only(left: 10),
    radius: 2,
    height: 50,
    bgColor: white,
    title: selectTimeTypeStr,
    fontName: FontName.bold,
    trailingIcon: const Padding(
      padding: EdgeInsets.only(left: 50.0, right: 10),
      child: Icon(Icons.arrow_drop_down_rounded),
    ),
    onTap: () {
      print("====== selectTimeTypeStr");
    },
  );
}
