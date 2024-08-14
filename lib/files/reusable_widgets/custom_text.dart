import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double? fontSize;
  final int? maxLine;
  final Color color;
  final TextAlign textAlign;
  final FontName fontName;
  const CustomText({
    super.key,
    required this.title,
    this.maxLine,
    this.color = black,
    this.fontSize,
    this.fontName = FontName.regular,
    this.textAlign = TextAlign.left,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLine,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontName.name,
      ),
    );
  }
}
