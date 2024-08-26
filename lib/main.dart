import 'dart:convert';

import 'package:etisalat/files/api_calls/authorization/auto_login_api.dart';
import 'package:etisalat/files/common/aes_enc_dec.dart';
import 'package:etisalat/files/controllers/app_controller.dart';
import 'package:etisalat/files/controllers/artists_tune_controller.dart';
import 'package:etisalat/files/controllers/banner_controller.dart';
import 'package:etisalat/files/controllers/banner_detail_controller.dart';
import 'package:etisalat/files/controllers/buy_tune_controller.dart';
import 'package:etisalat/files/controllers/category_detail_controller.dart';
import 'package:etisalat/files/controllers/custom_drawer_controller.dart';
import 'package:etisalat/files/controllers/gift_controller.dart';
import 'package:etisalat/files/controllers/home_controllers/feature_controller.dart';
import 'package:etisalat/files/controllers/music_box_controller.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/my_music_box_controller.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/my_playing_tune_controller.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/my_tune_controller.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/my_tune_setting_controller.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/tune_controller.dart';
import 'package:etisalat/files/controllers/my_wishlist_controller.dart';
import 'package:etisalat/files/controllers/name_tune_controller.dart';
import 'package:etisalat/files/controllers/player_controller.dart';
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
late AppController appCont;
late BuildContext globalContext;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await readProperties();
  prefs = await SharedPreferences.getInstance();

  await initiateController();
  StoreManager.initValues();
  fetchUriData();
  runApp(const MyApp());
}

fetchUriData() {
  var uri = Uri.parse(Uri.base.toString());
  if (uri.hasQuery) {
    uri.queryParameters.forEach((k, v) {
      if (k == 'token') {
        print("toekn is ");
        String decryptedMsdidn = aesDecryption(v.replaceAll(" ", "+"));
        autoLoginApi(decryptedMsdidn);
      }
    });
  }
}

Future<void> readProperties() async {
  final String value = await rootBundle.loadString('properties.json');
  final data = await json.decode(value);
  baseUrl = data['BASE_URL'];
  nameTuneCategoryId = data['NAME_TUNE_CAT_ID'];
  musicBoxPrice = data['BOX_CHARGE'];
  tuneChargePrice = data['TUNE_CHARGE'];

  customPrint("base url = $baseUrl");
  return;
}

Future<void> initiateController() async {
  Get.lazyPut(() => AppController());
  appCont = Get.find(); //put(AppController());
//Get.lazyPut(() => PlayerController());
  PlayerController _playCon = Get.put(PlayerController());

  Get.lazyPut(() => GiftController());
  Get.lazyPut(() => BuyTuneController());
  Get.lazyPut(() => TuneController());
  Get.lazyPut(() => OtpController());
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => PlayerController());
  Get.lazyPut(() => MyTuneController());
  Get.lazyPut(() => BannerController());
  Get.lazyPut(() => FeatureController());
  Get.lazyPut(() => ProfileController());
  Get.lazyPut(() => NameTuneController());
  Get.lazyPut(() => MusicBoxController());
  Get.lazyPut(() => MyMusicBoxController());
  Get.lazyPut(() => TuneSearchController());
  Get.lazyPut(() => CustomDrawerController());

  Get.lazyPut(() => MyWishlistController());
  Get.lazyPut(() => ArtistsTuneController());

  Get.lazyPut(() => BannerDetailController());
  Get.lazyPut(() => MyTuneSettingController());
  Get.lazyPut(() => MyPlayingTuneController());
  Get.lazyPut(() => CategoryDetailController());
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
