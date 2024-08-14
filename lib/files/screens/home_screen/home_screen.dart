import 'package:etisalat/files/controllers/auth_controller/login_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/screens/authentication_screen/login_otp_popup.dart';
import 'package:etisalat/files/screens/authentication_screen/login_popup.dart';
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
    return Center(
      child: SizedBox(
        child:
            // LoginPopup(
            //   onSuccess: () {
            //     print("object");

            //   },
            // )
            TextButton(
                onPressed: () {
                  print("tapped");
                  loginController.displayOptScreen.value = true;
                  loginController.onChangeMsidn('');
                  Get.dialog(Obx(
                    () {
                      return loginController.displayOptScreen.value
                          ? LoginOtpPopup()
                          : LoginPopup();
                    },
                  ));
                },
                child: CustomText(
                  title: "Open",
                  fontName: FontName.regular,
                )),
      ),
    );
  }
}
