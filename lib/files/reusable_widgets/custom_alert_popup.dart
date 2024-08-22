import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

openAlertPopup(
    {String? heading,
    required String message,
    String? primaryBtnTitle,
    String? secondryBtnTitle,
    Color? secondryTitleColor,
    Function()? onPrimary,
    Function()? onSecondry}) {
  Get.dialog(
      _CustomAlertPopup(
        heading: heading,
        message: message,
        primaryBtnTitle: primaryBtnTitle,
        secondryBtnTitle: secondryBtnTitle,
        secondryTitleColor: secondryTitleColor,
        onPrimary: onPrimary,
        onSecondry: onSecondry,
      ),
      barrierDismissible: false);
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
  });
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
                  textAlign: TextAlign.center,
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
      color: lightGrey,
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
