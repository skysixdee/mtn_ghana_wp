import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/main.dart';

bool isDarkTheme(BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;
  appCont.isDarkTheme.value = isDark;
  return isDark;
}
