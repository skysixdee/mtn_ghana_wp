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
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => OtpController());
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
      home: const HomeScreen(),
    );
  }
}
