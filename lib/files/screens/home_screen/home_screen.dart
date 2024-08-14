import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/screens/authentication_screen/login_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(child: LoginPopup()
          // TextButton(
          //     onPressed: () {
          //       print("tapped");
          //       Get.dialog(LoginPopup());
          //     },
          //     child: CustomText(
          //       title: "Open",
          //       fontName: FontName.regular,
          //     )),
          ),
    );
  }
}
