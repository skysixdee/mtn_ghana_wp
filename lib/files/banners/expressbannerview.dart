 import 'package:etisalat/files/utility/images.dart';
import 'package:flutter/material.dart';

Widget BottomExpressBanner() {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0,right: 4.0),
      child: Image.asset(
        expressPng,
        fit: BoxFit.cover,
      ),
    );
  }