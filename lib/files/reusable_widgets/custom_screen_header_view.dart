import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomScreenHeaderView extends StatelessWidget {
  CustomScreenHeaderView(
      {super.key,
      this.descFontSize,
      this.titleFontSize,
      this.height = 280,
      required this.imageName,
      required this.title,
      required this.subTitle});
  final String imageName;
  final String title;
  final String subTitle;
  final double height;
  final double? titleFontSize;
  final double? descFontSize;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Container(
          height: height,
          color: grey,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Image.asset(
                width: double.infinity,
                height: double.infinity,
                imageName,
                fit: BoxFit.fill,
              ),
              ovalShape(sizingInformation),
            ],
          ),
        );
      },
    );
  }

  Widget ovalShape(SizingInformation si) {
    return Positioned(
      right: -(height * 0.4),
      child: ClipOval(
        child: Container(
          width: si.isMobile ? height * 1.3 : height * 1.5,
          height: si.isMobile ? (height * 0.7) : height * 0.8,
          color: yellow,
          child: Padding(
            padding: EdgeInsets.only(left: 28.0, right: (height * 0.4) + 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: title,
                  fontName: FontName.bold,
                  fontSize: titleFontSize ?? 22,
                ),
                CustomText(
                  title: subTitle,
                  fontSize: descFontSize ?? 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyClip extends CustomClipper<Rect> {
  final double width;
  final double height;
  MyClip(this.height, {super.reclip, required this.width});

  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, width, height);
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}
