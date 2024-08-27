import 'package:etisalat/files/model/navigation_header_model.dart';
import 'package:etisalat/files/reusable_widgets/navigation_header_view.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';

Widget getNavigationView(String title) {
  return NavigationHeaderView(titleList: [
    NavigationHeaderModel(homeStr, homeRoute),
    NavigationHeaderModel(title, title)
  ]);
}
