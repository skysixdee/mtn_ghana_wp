import 'dart:ui';

import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/images.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ExpressInfoView extends StatelessWidget {
  const ExpressInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: yellow,
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
          opacity: 0.8, child: Image.asset(expressPng, color: Colors.black)),
      ClipRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Image.asset(expressPng)))
    ]);
  }

  Widget rightMessage(SizingInformation si) {
    List<String> messages = expressMoodMessage.split('\n');
    List<Widget> list = <Widget>[];
    for (var i = 0; i < messages.length; i++) {
      list.add(CustomText(
        title: messages[i],
        fontName: i == 0 ? FontName.bold : FontName.regular,
        fontSize: i == 0 ? (si.isMobile ? 20 : 40) : (si.isMobile ? 14 : 30),
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }
}
