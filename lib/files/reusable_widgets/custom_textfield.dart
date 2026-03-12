import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextfield extends StatelessWidget {
  CustomTextfield({
    super.key,
    this.leadingChild,
    this.fontFamily,
    this.maxLength,
    this.fontSize = 16,
    this.onChange,
    this.onSubmit,
    this.hintText,
    this.width,
    required this.controller,
    this.textAlign = TextAlign.start,
    this.enabled = true,
    this.obscureText = false,
    this.trailingChild,
    this.bgColor = transparent,
    this.borderColor = black,
    this.hintColor = grey,
    this.radius,
    this.isNumericTextField = false,
    this.clearIcon,
    this.addSearchIcon = false,
  });

  final Widget? leadingChild;
  final Widget? trailingChild;
  final String? fontFamily;
  final int? maxLength;
  final double? fontSize;
  final TextAlign textAlign;
  final String? hintText;
  final bool? enabled;
  final Color bgColor;
  final bool addSearchIcon;
  final Color hintColor;
  final Color borderColor;
  final double? width;
  final double? radius;
  final bool obscureText;
  final TextEditingController controller;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final RxString text = ''.obs;
  final bool isNumericTextField;
  final Widget? clearIcon;

  @override
  Widget build(BuildContext context) {
    text.value = controller.text;
    return Container(
      height: 40,
      width: width,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius ?? 20),
        border: Border.all(color: isDarkTheme(context) ? whiteD : borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leadingChild ?? const SizedBox(),
            Expanded(child: textField()),
            clearButton(context),
            trailingChild ?? searchIcons(context)
          ],
        ),
      ),
    );
    // Obx(
    //   () {
    //     return
    //   },
    // );
  }

  Widget searchIcons(BuildContext context) {
    return addSearchIcon
        ? Padding(
            padding: const EdgeInsets.all(1.0),
            child: GenericButton(
              width: 38,
              bgColor: isDarkTheme(context) ? whiteD : white,
              padding: EdgeInsets.zero,
              leadingIcon: const Icon(
                Icons.search,
                size: 20,
              ),
              onTap: () {
                if (onSubmit != null) {
                  onSubmit!(controller.text);
                  customPrint("Search taped ${controller.text}");
                }
              },
            ),
          )
        : const SizedBox(width: 4);
  }

  Widget clearButton(BuildContext context) {
    return clearIcon ??
        Obx(
          () {
            return Visibility(
              visible: text.isNotEmpty,
              child: InkWell(
                  onTap: () {
                    if (!enabled!) {
                      return;
                    }
                    controller.text = '';
                    text.value = '';
                    if (onChange != null) {
                      onChange!("");
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, bottom: 8, top: 8, right: 8),
                    child: Icon(
                      color: enabled!
                          ? isDarkTheme(context)
                              ? whiteD
                              : null
                          : grey,
                      Icons.close,
                      size: 14,
                    ),
                  )),
            );
          },
        );
  }

  TextField textField() {
    return TextField(
      autofocus: true,
      obscureText: obscureText,
      enabled: enabled,
      textAlign: textAlign,
      controller: controller,
      onChanged: (v) {
        text.value = v;
        if (onChange != null) {
          onChange!(v);
        }
      },
      onSubmitted: (v) {
        if (onSubmit != null) {
          onSubmit!(v);
        }
      },
      maxLength: maxLength,
      inputFormatters:
          isNumericTextField ? [FilteringTextInputFormatter.digitsOnly] : null,
      style: textStyle(),
      decoration: inputDecoration(),
    );
  }

  TextStyle textStyle() {
    return TextStyle(
      fontFamily: fontFamily ?? FontName.regular.name,
      fontSize: fontSize,
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      hintText: hintText ?? searchPlaceHolderStr,
      hintStyle: TextStyle(
        fontFamily: fontFamily ?? FontName.regular.name,
        fontSize: fontSize! - 2,
        color: hintColor,
      ),
      counterText: '',
      isDense: true,
      border: InputBorder.none,
    );
  }
}
