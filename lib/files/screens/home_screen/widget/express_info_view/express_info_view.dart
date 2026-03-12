import 'dart:ui';

import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ExpressInfoView extends StatelessWidget {
  const ExpressInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: isDarkTheme(context) ? yellowD : yellow,
        child: ResponsiveBuilder(
          builder: (context, si) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: si.isMobile ? 18 : 25,
                  vertical: si.isMobile ? 24 : 30),
              child: (si.isMobile || si.isTablet)
                  ? rightMessage(si)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 400,
                          child: leftImage(),
                        ),
                        Flexible(child: rightMessage(si)),
                      ],
                    ),
            );
          },
        ));
  }

  Widget leftImage() {
    return Stack(children: [
      Opacity(
          opacity: 0.8,
          child: Image.asset(
            expressPng,
            color: Colors.black,
            height: 230,
          )),
      ClipRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Image.asset(expressPng, height: 230)))
    ]);
  }

  Widget rightMessage(SizingInformation si) {
    List<String> expressLines = expressMoodMessage.split('\n');
    List<String> fallbackLines = fallBackCharge.split('\n');

    List<Widget> list = <Widget>[];

    for (var i = 0; i < expressLines.length; i++) {
      list.add(CustomText(
        colorD: blackD,
        title: expressLines[i],
        fontName: i == 0 ? FontName.bold : FontName.regular,
        fontSize: i == 0 ? (si.isMobile ? 18 : 25) : (si.isMobile ? 14 : 20),
        //fontSize: i == 0 ? (si.isMobile ? 14 : 20) : (si.isMobile ? 10 : 15),
      ));
    }

    for (var i = 0; i < fallbackLines.length; i++) {
      list.add(
        Padding(
          padding: EdgeInsets.only(left: si.isMobile ? 12 : 20),
          child: CustomText(
            colorD: blackD,
            title: fallbackLines[i].trim(),
            fontName: FontName.regular,
            fontSize: si.isMobile ? 10 : 15,
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  // Widget rightMessage(SizingInformation si) {
  //   List<String> messages = expressMoodMessage.split('\n');

  //   List<Widget> list = <Widget>[];
  //   for (var i = 0; i < messages.length; i++) {
  //     list.add(CustomText(
  //       title: messages[i],
  //       fontName: i == 0 ? FontName.bold : FontName.regular,
  //       fontSize: i == 0 ? (si.isMobile ? 14 : 20) : (si.isMobile ? 10 : 15),
  //       //fontSize: i == 0 ? (si.isMobile ? 18 : 25) : (si.isMobile ? 14 : 20),
  //       // fontSize: i == 0 ? (si.isMobile ? 20 : 40) : (si.isMobile ? 14 : 30),
  //     ));
  //   }
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: list,
  //   );
  // }
}
