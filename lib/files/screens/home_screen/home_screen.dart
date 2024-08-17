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
    return ListView(
      shrinkWrap: true,
      primary: true,
      children: [
        GenericButton(
          title: "Set value",
          onTap: () {
            StoreManager.setLoggedIn(true);
            StoreManager.setMsisdn("0832120732");
            StoreManager.setAccessToken("66a64a44-9c93-47ea-951a-09f6851b61e8");
            StoreManager.setRefreshToken(
                "d4d7c1f9-a187-43ca-be31-12f3c9951e05");
            StoreManager.setDeviceId("096c3442-a697-455b-a495-adc07c158638");
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
