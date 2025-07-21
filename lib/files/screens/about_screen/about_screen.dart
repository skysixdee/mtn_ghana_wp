import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        title: "About page ",
      ),
    );
  }
}
