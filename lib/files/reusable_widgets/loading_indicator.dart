import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator(
    {double? height = 40, double? width, double radius = 16}) {
  return SizedBox(
    height: height,
    width: width,
    child: Center(
        child: CupertinoActivityIndicator(
      radius: radius,
    )),
  );
}
