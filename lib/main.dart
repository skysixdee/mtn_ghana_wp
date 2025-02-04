import 'dart:convert';

import 'package:mtn_ghana_wp/files/api_calls/authorization/auto_login_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/create_blaclist_controller.dart';
import 'package:mtn_ghana_wp/files/common/aes_enc_dec.dart';
import 'package:mtn_ghana_wp/files/controllers/app_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/artists_tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/banner_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/banner_detail_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/blacklist_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/buy_tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/category_detail_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/custom_drawer_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/gift_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/home_controllers/feature_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/music_box_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_music_box_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_playing_tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_tune_setting_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_wishlist_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/name_tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/player_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/profile_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/tune_search_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/router/router.dart';
import 'package:mtn_ghana_wp/files/screens/category_detail_screen/category_detail_screen.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:mtn_ghana_wp/files/controllers/auth_controller/otp_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/auth_controller/login_controller.dart';
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
  expressMoodMessage = data['EXPRESS_MOOD_MESSAGE'];
  termsAndConditionUrl = data['TERMS_AND_CONDITION_URL'];
  privacyPolicyUrl = data['PRIVACY_POLICY'];
  countryCode = data['COUNTRY_CODE'];
  msisdnLength=data["MSISDN_LENGTH"];
  otpLength=data["OTP_LENGTH"];
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
  Get.lazyPut(() => CreateBlaclistController());
  Get.lazyPut(() => BlacklistController());
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
      title: 'mtn_ghana_wp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 222, 205, 18)),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
