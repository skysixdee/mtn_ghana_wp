import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';

class SideMenuView extends StatelessWidget {
  const SideMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sideMenuWidth,
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.4),
            blurRadius: 4,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Center(child: Text("data")),
    );
  }
}
