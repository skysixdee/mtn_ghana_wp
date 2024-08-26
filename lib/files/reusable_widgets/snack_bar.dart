import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
