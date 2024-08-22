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
    String? message,
    String? primaryBtnTitle,
    String? secondryBtnTitle,
    Function()? onPrimary,
    Function()? onSecondry}) {
  Get.dialog(
      _CustomAlertPopup(
        heading: heading,
        message: message,
        primaryBtnTitle: primaryBtnTitle,
        secondryBtnTitle: secondryBtnTitle,
        onPrimary: onPrimary,
        onSecondry: onSecondry,
      ),
      barrierDismissible: true);
}

class _CustomAlertPopup extends StatelessWidget {
  const _CustomAlertPopup({
    super.key,
    this.heading,
    this.message,
    this.primaryBtnTitle,
    this.secondryBtnTitle,
    this.onPrimary,
    this.onSecondry,
  });
  final String? heading;
  final String? message;
  final String? primaryBtnTitle;
  final String? secondryBtnTitle;
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
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: CustomText(
                  title: message,
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
            bgColor: transparent,
            title: primaryBtnTitle ?? okCStr,
            onTap: () {
              if (onPrimary != null) {
                Navigator.of(context).pop();
                onPrimary!();
              }
            },
          )
        : SizedBox(
            height: 45,
            child: Row(
              children: [
                Expanded(
                  child: GenericButton(
                    title: secondryBtnTitle,
                    bgColor: transparent,
                    onTap: () {
                      if (onSecondry != null) {
                        Navigator.of(context).pop();
                        onSecondry!();
                      }
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
                    title: primaryBtnTitle ?? okCStr,
                    bgColor: transparent,
                    onTap: () {
                      if (onPrimary != null) {
                        Navigator.of(context).pop();
                        onPrimary!();
                      }
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
