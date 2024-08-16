import 'package:etisalat/files/controllers/auth_controller/login_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/popup_views/gift_popup_view.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/screens/authentication_screen/login_otp_popup.dart';
import 'package:etisalat/files/screens/authentication_screen/login_popup.dart';
import 'package:etisalat/files/screens/home_screen/widget/home_banner_view/home_banner_view.dart';
import 'package:etisalat/files/screens/home_screen/widget/feature_view/feature_category_view.dart';
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
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        GenericButton(
          title: "Set value",
          onTap: () {
            StoreManager.setLoggedIn(true);
            StoreManager.setMsisdn("0832120732");
            StoreManager.setAccessToken("806e1e60-243d-438d-94a5-59e2e2373f93");
            StoreManager.setRefreshToken(
                "b1ed6f60-47a3-486e-af8a-e4389349d402");
            StoreManager.setDeviceId("46766c37-a10b-4753-b0f8-7896efae1353");
          },
        ),
        ProfileScreen(key: widget.key),
        const SizedBox(height: 8),
        HomeBannerView(key: widget.key),
        const SizedBox(height: 10),
        FeatureCategoryView(key: widget.key),
      ],
    );
  }
}
