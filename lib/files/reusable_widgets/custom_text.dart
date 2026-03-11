import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomText extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final int? maxLine;
  final Color color;
  final TextAlign? textAlign;
  final FontName fontName;
  const CustomText({
    super.key,
    this.title,
    this.maxLine,
    this.color = black,
    this.fontSize,
    this.fontName = FontName.regular,
    this.textAlign = TextAlign.left,
  });
  @override
  Widget build(BuildContext context) {
    return title == null
        ? const SizedBox()
        : Text(
            title ?? '',
            maxLines: maxLine,
            textAlign: textAlign,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? checkColur(context, color)
                  : color,
              fontSize: fontSize,
              fontFamily: fontName.name,
            ),
          );
  }

  Color checkColur(BuildContext context, Color col) {
    if (col == black) {
      return whiteD;
    } else if (col == yellow) {
      return yellowD;
    } else {
      return black;
    }
  }
}
/*

ResponsiveBuilder(
            builder: (context, si) {
              return Text(
                title ?? '',
                maxLines: maxLine,
                textAlign: textAlign,
                style: TextStyle(
                  color: color,
                  fontSize: (fontSize ?? 14) * (si.isMobile ? 0.85 : 1),
                  fontFamily: fontName.name,
                ),
              );
            },
          );
*/
