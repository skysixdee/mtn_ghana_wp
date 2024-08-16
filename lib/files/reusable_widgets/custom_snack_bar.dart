import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

customSnackBar(String? message) {
  Get.snackbar("", "",
      maxWidth: 400,
      messageText:
          Center(child: CustomText(title: message ?? someThingWentWrongStr)),
      backgroundColor: yellow,
      snackPosition: SnackPosition.BOTTOM);
}
