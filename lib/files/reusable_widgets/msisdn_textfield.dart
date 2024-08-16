import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MsisdnTextfield extends StatelessWidget {
  MsisdnTextfield({
    super.key,
    this.leadingChild,
    this.fontFamily,
    this.maxLength = msisdnLength,
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
  final double? width;
  final bool obscureText;
  final TextEditingController controller;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final RxString text = ''.obs;

  @override
  Widget build(BuildContext context) {
    text.value = controller.text;
    return Obx(
      () {
        return Container(
          height: 40,
          width: width,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: black),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leadingChild ?? const SizedBox(),
                Expanded(child: textField()),
                clearButton(),
                trailingChild ?? const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget clearButton() {
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
          child: enabled!
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 8, bottom: 8, top: 8, right: 0),
                  child: Icon(
                    color: enabled! ? null : grey,
                    Icons.close,
                    size: 14,
                  ),
                )
              : SizedBox()),
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
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
      hintText: hintText ?? enterMobileNumberStr,
      hintStyle: TextStyle(
        fontFamily: fontFamily ?? FontName.regular.name,
        fontSize: fontSize! - 2,
        color: grey,
      ),
      counterText: '',
      isDense: true,
      border: InputBorder.none,
    );
  }
}
