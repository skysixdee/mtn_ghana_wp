import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/router/router.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackBar(String? message) {
  if (scaffoldKey.currentContext == null) {
    print(
        "snack bar can not be displayed cause scaffoldKey.currentContext == null");
    return;
  }
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: Container(
          width: 400,
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: yellow, // your custom color
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: CustomText(
              title: message ?? someThingWentWrongStr,
              textAlign: TextAlign.center,
              fontName: FontName.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    ),
  );

  ScaffoldMessenger.of(scaffoldKey.currentContext!)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

/*
snackBar(String? message) {
  Get.snackbar("", "",
      maxWidth: 400,
      messageText: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: yellow,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Center(
                child: CustomText(
              title: message ?? someThingWentWrongStr,
              textAlign: TextAlign.center,
              fontName: FontName.bold,
            )),
          )),
      backgroundColor: transparent,
      snackPosition: SnackPosition.BOTTOM);
}
*/
