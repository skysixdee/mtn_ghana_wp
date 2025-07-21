import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/popup_views/generic_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

openAlertPopup(
    {String? heading,
    required String message,
    String? primaryBtnTitle,
    String? secondryBtnTitle,
    Color? secondryTitleColor,
    final TextAlign? textAlign,
    Function()? onPrimary,
    Function()? onSecondry}) {
  genericPopup(
    _CustomAlertPopup(
      heading: heading,
      message: message,
      primaryBtnTitle: primaryBtnTitle,
      secondryBtnTitle: secondryBtnTitle,
      secondryTitleColor: secondryTitleColor,
      onPrimary: onPrimary,
      onSecondry: onSecondry,
      textAlign: textAlign,
    ),
  );
}

class _CustomAlertPopup extends StatelessWidget {
  const _CustomAlertPopup({
    super.key,
    this.heading,
    required this.message,
    this.primaryBtnTitle,
    this.secondryBtnTitle,
    this.onPrimary,
    this.onSecondry,
    this.secondryTitleColor,
    this.textAlign,
  });
  final TextAlign? textAlign;
  final String? heading;
  final String message;
  final String? primaryBtnTitle;
  final String? secondryBtnTitle;
  final Color? secondryTitleColor;
  final Function()? onPrimary;
  final Function()? onSecondry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          color: transparent,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: white,
            ),
            width: popupWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                header(context),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: CustomText(
                    title: message,
                    fontSize: 16,
                    textAlign: textAlign ?? TextAlign.center,
                  ),
                ),
                Column(
                  children: [
                    verticatDivider(),
                    bottomButtons(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget verticatDivider() {
    return Container(
      height: 1,
      color: lightGrey,
    );
  }

  Widget bottomButtons(BuildContext context) {
    return secondryBtnTitle == null
        ? GenericButton(
            radius: 0,
            height: 45,
            fontSize: 16,
            bgColor: transparent,
            title: primaryBtnTitle ?? okCStr,
            onTap: () {
              if (onPrimary != null) {
                onPrimary!();
              }
              Navigator.of(context).pop();
            },
          )
        : SizedBox(
            height: 45,
            child: Row(
              children: [
                Expanded(
                  child: GenericButton(
                    fontSize: 16,
                    textColor: secondryTitleColor ?? red,
                    title: secondryBtnTitle,
                    bgColor: transparent,
                    onTap: () {
                      if (onSecondry != null) {
                        onSecondry!();
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                  child: Center(
                    child: Container(
                      color: lightGrey,
                      width: 1,
                      height: double.infinity,
                    ),
                  ),
                ),
                Expanded(
                  child: GenericButton(
                    fontSize: 16,
                    title: primaryBtnTitle ?? okCStr,
                    bgColor: transparent,
                    onTap: () {
                      if (onPrimary != null) {
                        onPrimary!();
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
  }

  Widget header(BuildContext context) {
    return Container(
      color: yellow,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 30),
          Expanded(
            child: CustomText(
              textAlign: TextAlign.center,
              title: heading,
              fontName: FontName.bold,
            ),
          ),
          GenericButton(
            padding: EdgeInsets.zero,
            width: 40,
            leadingIcon: const Icon(Icons.close),
            bgColor: transparent,
            onTap: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
