import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              title: title,
              fontName: FontName.bold,
              fontSize: 18,
            ),
            SizedBox(height: 12),
            CustomText(
              title: thisFeatureIsAvailableForLoggedinStr,
              fontName: FontName.bold,
              textAlign: TextAlign.center,
              fontSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}
