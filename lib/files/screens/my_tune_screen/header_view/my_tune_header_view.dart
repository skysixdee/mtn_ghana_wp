import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
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
          color: yellow,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                SizedBox(
                  width: si.isMobile ? ovalSize * 0.7 : ovalSize * 1.1,
                  height: si.isMobile ? ovalSize / 2 : ovalSize * 0.75,
                  child: Positioned(
                    left: 100,
                    child: ClipOval(
                      child: Container(
                        height: si.isMobile ? ovalSize / 2 : ovalSize * 0.85,
                        color: white,
                      ),
                      clipper: MyClip(si, ovalSize: ovalSize),
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
