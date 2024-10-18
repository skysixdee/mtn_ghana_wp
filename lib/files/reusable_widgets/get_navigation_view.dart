import 'package:mtn_ghana_wp/files/model/navigation_header_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/navigation_header_view.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';

Widget getNavigationView(String title, {Widget? rightButton}) {
  return NavigationHeaderView(
    titleList: [
      NavigationHeaderModel(homeStr, homeRoute),
      NavigationHeaderModel(title, title),
    ],
    rightButton: rightButton,
  );
}
