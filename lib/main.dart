import 'dart:convert';

import 'package:etisalat/files/controllers/app_controller.dart';
import 'package:etisalat/files/controllers/banner_controller.dart';
import 'package:etisalat/files/controllers/banner_detail_controller.dart';
import 'package:etisalat/files/controllers/category_detail_controller.dart';
import 'package:etisalat/files/controllers/home_controllers/feature_controller.dart';
import 'package:etisalat/files/controllers/music_box_controller.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/my_music_box_controller.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/my_playing_tune_controller.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/my_tune_controller.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/tune_controller.dart';
import 'package:etisalat/files/controllers/my_wishlist_controller.dart';
import 'package:etisalat/files/controllers/name_tune_controller.dart';
import 'package:etisalat/files/controllers/profile_controller.dart';
import 'package:etisalat/files/controllers/tune_search_controller.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/router/router.dart';
import 'package:etisalat/files/screens/category_detail_screen/category_detail_screen.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:etisalat/files/controllers/auth_controller/otp_controller.dart';
import 'package:etisalat/files/controllers/auth_controller/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await readProperties();
  prefs = await SharedPreferences.getInstance();
  StoreManager.initValues();

  await initiateController();
  runApp(const MyApp());
}

Future<void> readProperties() async {
  final String value = await rootBundle.loadString('properties.json');
  final data = await json.decode(value);
  baseUrl = data['BASE_URL'];
  customPrint("base url = $baseUrl");
  return;
}

Future<void> initiateController() async {
  AppController _ = Get.put(AppController());

  Get.lazyPut(() => TuneController());
  Get.lazyPut(() => OtpController());
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => MyTuneController());
  Get.lazyPut(() => BannerController());
  Get.lazyPut(() => FeatureController());
  Get.lazyPut(() => ProfileController());
  Get.lazyPut(() => NameTuneController());
  Get.lazyPut(() => MusicBoxController());
  Get.lazyPut(() => MyMusicBoxController());
  Get.lazyPut(() => TuneSearchController());
  Get.lazyPut(() => CategoryDetailScreen());
  Get.lazyPut(() => MyWishlistController());
  Get.lazyPut(() => BannerDetailController());
  Get.lazyPut(() => MyPlayingTuneController());
  Get.lazyPut(() => CategoryDetailController());

  return;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Etisalat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 222, 205, 18)),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
