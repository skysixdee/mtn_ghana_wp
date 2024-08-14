import 'package:etisalat/files/controllers/auth_controller/login_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/screens/authentication_screen/login_otp_popup.dart';
import 'package:etisalat/files/screens/authentication_screen/login_popup.dart';
import 'package:etisalat/files/screens/home_screen/widget/feature_view/feature_category_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoginController loginController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        FeatureCategoryView(),
        Container(
          height: 300,
          color: Colors.purple,
        ),
        Container(
          height: 300,
          color: Colors.red,
        ),
        Container(
          height: 300,
          color: Colors.yellow,
        ),
        Container(
          height: 300,
          color: Colors.purple,
        ),
        Container(
          height: 300,
          color: Colors.blue,
        ),
        Container(
          height: 300,
          color: Colors.purple,
        ),
        Container(
          height: 300,
          color: Colors.yellow,
        ),
        Container(
          height: 300,
          color: Colors.purple,
        ),
        Container(
          height: 300,
          color: Colors.blue,
        ),
        Container(
          height: 300,
          color: Colors.purple,
        ),
      ],
    );
  }
}
