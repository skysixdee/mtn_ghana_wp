import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/images.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyTuneHeaderView extends StatelessWidget {
  const MyTuneHeaderView({super.key});
  final double ovalSize = 300;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          color: grey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Image.asset(
                  myTuneHeaderPng,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: si.isMobile ? ovalSize * 0.7 : ovalSize * 1.1,
                  height: si.isMobile ? ovalSize / 2 : ovalSize * 0.75,
                  child: Positioned(
                    left: 100,
                    child: ClipOval(
                      clipper: MyClip(si, ovalSize: ovalSize),
                      child: Container(
                        height: si.isMobile ? ovalSize / 2 : ovalSize * 0.85,
                        color: yellow,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40, right: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: setYourTuneStr,
                                fontName: FontName.bold,
                                fontSize: si.isMobile ? 16 : 24,
                              ),
                              CustomText(
                                title: customiseYourTuneStr,
                                fontSize: si.isMobile ? 14 : 18,
                              ),
                              SizedBox(
                                height: si.isMobile ? 8 : 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyClip extends CustomClipper<Rect> {
  final double ovalSize;
  final SizingInformation si;
  MyClip(this.si, {super.reclip, required this.ovalSize});
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, si.isMobile ? ovalSize : ovalSize * 1.4,
        si.isMobile ? ovalSize / 2 : ovalSize * 0.70);
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}
