import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

Widget gradientButton({
  required String title,
  required bool isLoading,
  required VoidCallback onPressed,
}) {
  return Container(
    height: 35,
    width: 140,
    decoration: BoxDecoration(
      gradient: isLoading ? null : null,
      // borderRadius: BorderRadius.only(
      //   topLeft: Radius.circular(15),
      //   bottomLeft: Radius.circular(2),
      //   topRight: Radius.circular(2),
      //   bottomRight: Radius.circular(15),
      // ),
    ),
    child: isLoading
        ? Center(child: loadingIndicator(height: 20, width: 20, radius: 10))
        : ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(transparent),
              shadowColor: WidgetStateProperty.all(transparent),
              elevation: WidgetStateProperty.all(0),
              padding:
                  WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 12)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                  bottomRight: Radius.circular(15),
                ),
              )),
            ),
            onPressed: onPressed,
            child: CustomText(
              isSelectable: false,
              title: title,
              fontName: FontName.regular,
              fontSize: 13,
              color: white,
            ),
          ),
  );
}
