import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/banners/bottombannerview.dart';
import 'package:etisalat/files/banners/expressbannerview.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/controllers/music_box_controller.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/screens/home_screen/widget/music_box_view.dart';
import 'package:etisalat/files/screens/home_screen/widget/home_banner_view/home_banner_view.dart';
import 'package:etisalat/files/screens/home_screen/widget/feature_view/feature_category_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          tempWidget(),
          const SizedBox(height: 8),
          HomeBannerView(key: widget.key),
          const SizedBox(height: 20),
          const MusicBoxView(),
          const SizedBox(height: 30),
          FeatureCategoryView(key: widget.key),
          const SizedBox(height: 30),
          BottomExpressBanner(),
          const BottomBannerView(),
        ],
      ),
    );
  }

  Padding tempWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }
}

Map<String, dynamic> loginJson = {
  "respDesc": "Login Check Success",
  "srvType": "CHECKPASSWORD",
  "userIdEnc": "209-72-252-145-121-240-173-222",
  "userName": "0832120732",
  "accessToken": "d5b6de58-6837-4cd3-bac5-df3afc01ff50",
  "userId": "268",
  "deviceId": "87c13c09-2b0f-4198-afe1-53688c114b6b",
  "clientTxnId": "772085134",
  "msisdn": "0832120732",
  "txnId": "95435759397332",
  "refreshToken": "95edd40e-7a62-412b-9f7b-5750c3e9f0e9"
};
