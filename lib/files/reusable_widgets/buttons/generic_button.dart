import 'package:mtn_ghana_wp/files/common/custom_audio_player.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  const GenericButton({
    super.key,
    this.title,
    this.bgColor = lightGrey,
    this.textColor = black,
    this.padding,
    this.width,
    this.height = 40,
    this.radius,
    this.leadingIcon,
    this.trailingIcon,
    this.onTap,
    this.fontName = FontName.bold,
    this.borderColor,
    this.fontSize,
    this.isStopPlay = false,
    this.enable = true,
  });
  final bool isStopPlay;
  final bool enable;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final String? title;
  final Color bgColor;
  final Color? borderColor;
  final Color textColor;
  final double? width;
  final double height;
  final double? radius;
  final FontName fontName;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? transparent),
          borderRadius: BorderRadius.circular(radius ?? height / 2),
          color: bgColor,
        ),
        width: width,
        child: InkWell(
          onTap: () {
            if (!enable) {
              return;
            }
            if (onTap != null) {
              onTap!();
            }
            if (!isStopPlay) {
              CustomAudioPlayer.instance.stop();
            }
          },
          child: Padding(
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        leadingIcon ?? const SizedBox(),
                        CustomText(
                          title: title ?? '',
                          color: textColor,
                          fontName: fontName,
                          fontSize: fontSize,
                        ),
                        trailingIcon ?? const SizedBox(),
                      ],
                    ),
                  )),
                ],
              )),
        ));
  }
}
