import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/material.dart';

class MyTuneHeaderView extends StatelessWidget {
  const MyTuneHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipOval(
              child: Container(
                height: 100,
                color: white,
              ),
              clipper: MyClip(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 200, 100);
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}
