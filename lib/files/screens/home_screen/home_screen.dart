import 'dart:convert';

import 'package:etisalat/files/api_calls/get_my_music_box_api.dart';
import 'package:etisalat/files/api_calls/get_my_tune_api.dart';
import 'package:etisalat/files/api_calls/get_playing_tune_api.dart';
import 'package:etisalat/files/controllers/auth_controller/login_controller.dart';
import 'package:etisalat/files/controllers/music_box_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/popup_views/gift_popup_view.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_alert_popup.dart';
import 'package:etisalat/files/reusable_widgets/custom_textfield.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/time_date_picker.dart';
import 'package:etisalat/files/screens/authentication_screen/login_otp_popup.dart';
import 'package:etisalat/files/screens/authentication_screen/login_popup.dart';
import 'package:etisalat/files/banners/bottombannerview.dart';
import 'package:etisalat/files/banners/expressbannerview.dart';
import 'package:etisalat/files/screens/home_screen/diy_screen.dart';
import 'package:etisalat/files/screens/home_screen/remainder_screen.dart';
import 'package:etisalat/files/screens/home_screen/widget/home_banner_view/home_banner_view.dart';
import 'package:etisalat/files/screens/home_screen/widget/feature_view/feature_category_view.dart';
import 'package:etisalat/files/screens/home_screen/widget/music_box_view.dart';
import 'package:etisalat/files/screens/my_tune_screen/my_tune_screen.dart';
import 'package:etisalat/files/screens/profile_screen/profile_screen.dart';
import 'package:etisalat/files/screens/web_navigation_view/web_navigation_view.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/colors.dart';
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
  DateTime p0 = DateTime.now();
  @override
  void initState() {
    musicBoxController.getMusicBox();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return //MyTuneScreen();
        Material(
      color: white,
      child: ListView(
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
          // CustomSearchTextfield(controller: TextEditingController(),
          // trailingChild: SizedBox(

          // ),),
          //   GenericButton(title: "hvv",leadingIcon: ,)
          GenericButton(
            title: " DiyScreen",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DiyScreen()),
              );

              RemainderScreen();
            },
          ),
          GenericButton(
            title: "RemainderScreen",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RemainderScreen()),
              );
            },
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              GenericButton(
                title: " Open Time",
                onTap: () {
                  openAlertPopup(
                    heading: "Heading",
                    message:
                        "https://ringtune.mpt.com.mm/apigw/Middleware/api/adapter/v1/crbt/settings",
                    onPrimary: () {
                      print("Primary call back");
                    },
                    onSecondry: () {
                      print("Secondry call back");
                    },
                  );
                  return;
                  Get.dialog(
                      barrierDismissible: true,
                      TimeDatePicker(
                          dateTime: p0,
                          onConfirm: (p0) {
                            this.p0 = p0;
                          },
                          onlyTime: true));
                },
              ),
              GenericButton(
                title: " Open Calender",
                onTap: () {
                  Get.dialog(
                      barrierDismissible: true,
                      TimeDatePicker(
                        dateTime: p0,
                        onConfirm: (p0) {
                          this.p0 = p0;
                        },
                      ));
                },
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 38.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GenericButton(
                  title: "Login",
                  onTap: () {
                    Map<String, dynamic> map1 = loginJson.map((k, v) {
                      customPrint("key == $k");
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
                    customPrint("map 1 ====== $map1");
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          HomeBannerView(key: widget.key),
          const SizedBox(height: 10),
          const MusicBoxView(),
          const SizedBox(height: 10),
          FeatureCategoryView(key: widget.key),
          const SizedBox(height: 30),

          BottomExpressBanner(),
          BottomBannerView(),
        ],
      ),
    );
  }
}

Map<String, dynamic> loginJson = {
  "respDesc": "Login Check Success",
  "srvType": "CHECKPASSWORD",
  "userIdEnc": "204-89-4-246-217-163-118-248",
  "userName": "09420784096",
  "accessToken": "6864cb81-52db-4be8-a7f6-16bd87febe3b",
  "userId": "7997",
  "deviceId": "0191212",
  "clientTxnId": "21042020",
  "msisdn": "09420784096",
  "txnId": "48435564272285",
  "refreshToken": "881be783-87a7-48f6-82f4-e6211616422e"
};
