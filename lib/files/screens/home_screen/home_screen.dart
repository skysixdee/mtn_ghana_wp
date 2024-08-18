import 'dart:convert';

import 'package:etisalat/files/api_calls/get_my_music_box_api.dart';
import 'package:etisalat/files/api_calls/get_my_tune_api.dart';
import 'package:etisalat/files/api_calls/get_playing_tune_api.dart';
import 'package:etisalat/files/controllers/auth_controller/login_controller.dart';
import 'package:etisalat/files/controllers/music_box_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/popup_views/gift_popup_view.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/screens/authentication_screen/login_otp_popup.dart';
import 'package:etisalat/files/screens/authentication_screen/login_popup.dart';
import 'package:etisalat/files/screens/home_screen/widget/home_banner_view/home_banner_view.dart';
import 'package:etisalat/files/screens/home_screen/widget/feature_view/feature_category_view.dart';
import 'package:etisalat/files/screens/home_screen/widget/music_box_view.dart';
import 'package:etisalat/files/screens/my_tune_screen/my_tune_screen.dart';
import 'package:etisalat/files/screens/profile_screen/profile_screen.dart';
import 'package:etisalat/files/screens/web_navigation_view/web_navigation_view.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoginController loginController = Get.find();
  MusicBoxController musicBoxController = Get.find();
  @override
  void initState() {
    musicBoxController.getMusicBox();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return //MyTuneScreen();
        ListView(
      shrinkWrap: true,
      primary: true,
      children: [
        GenericButton(
          title: "make api call",
          onTap: () {
            getMyMusicBoxApi();
            getMyTuneApi();
            getMyPlayingTuneApi();
          },
        ),
        GenericButton(
          title: "Set value",
          onTap: () {
            Map<String, dynamic> map1 = loginJson.map((k, v) {
              print("key == $k");
              if (k == 'accessToken') {
                StoreManager.setAccessToken(v as String);
              }
              if (k == 'refreshToken') {
                StoreManager.setRefreshToken(v as String);
              }
              if (k == 'deviceId') {
                StoreManager.setDeviceId(v as String);
              }
              if (k == 'msisdn') {
                StoreManager.setMsisdn(v as String);
                StoreManager.setLoggedIn(true);
              }

              return MapEntry(v, k);
            });
            print("map 1 ====== $map1");
          },
        ),
        const SizedBox(height: 8),
        HomeBannerView(key: widget.key),
        const SizedBox(height: 10),
        const MusicBoxView(),
        const SizedBox(height: 10),
        FeatureCategoryView(key: widget.key),
        const SizedBox(height: 300),
        const SizedBox(height: 300),
      ],
    );
  }
}

Map<String, dynamic> loginJson = {
  "respDesc": "Login Check Success",
  "srvType": "CHECKPASSWORD",
  "userIdEnc": "209-72-252-145-121-240-173-222",
  "userName": "0832120732",
  "accessToken": "4e476a89-35fb-46c9-b414-5733323fa1af",
  "userId": "268",
  "deviceId": "19c13264-c867-4826-8b82-b907ab3922b4",
  "clientTxnId": "578556083",
  "msisdn": "0832120732",
  "txnId": "69435135374975",
  "refreshToken": "a7d997ef-5abe-48b9-99c1-cf4b176029e9"
};
