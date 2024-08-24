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
  "accessToken": "e0573f30-aa87-4f0f-ad22-72b7e6d77d33",
  "userId": "268",
  "deviceId": "ab6a7fb5-9c55-49df-99d4-652ec844fa91",
  "clientTxnId": "638810846",
  "msisdn": "0832120732",
  "txnId": "95435583250581",
  "refreshToken": "17c5efaa-5672-4a2f-9acd-ee2c1bb1832a"
};
