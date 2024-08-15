import 'package:etisalat/files/controllers/app_controller.dart';
import 'package:etisalat/files/controllers/banner_controller.dart';
import 'package:etisalat/files/controllers/home_controllers/feature_controller.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:etisalat/files/screens/home_screen/home_screen.dart';
import 'package:etisalat/files/controllers/auth_controller/otp_controller.dart';
import 'package:etisalat/files/controllers/auth_controller/login_controller.dart';

void main() async {
  await initiateController();
  runApp(const MyApp());
}

Future<void> initiateController() async {
  AppController _ = Get.put(AppController());
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => OtpController());
  Get.lazyPut(() => BannerController());

  Get.lazyPut(() => FeatureController());
  return;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Etisalat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: Material(color: white, child: const HomeScreen()),
    );
  }
}
