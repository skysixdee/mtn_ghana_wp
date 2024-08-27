import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/material.dart';

class CustomScreenHeaderView extends StatelessWidget {
  CustomScreenHeaderView({super.key, this.child, this.height = 200});
  final Widget? child;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.teal,
      child: child ?? const SizedBox(),
    );
  }
}
