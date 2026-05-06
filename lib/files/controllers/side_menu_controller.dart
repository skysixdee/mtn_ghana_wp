import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class SideMenuController extends GetxController {
  Rx<SideMenuModel> selectedCard = SideMenuModel(homeStr, homeRoute).obs;
  List<SideMenuModel> sideMenuList = [
    SideMenuModel(homeStr, homeRoute,
        leading: SvgPicture.asset(
          homeSideMenuIcon,
          height: 22,
          color: grey,
        )),
    // SideMenuModel(myProfileStr, profileRoute,
    //     leadingIconData: CupertinoIcons.home),
    SideMenuModel(myTunezStr, myTunesRoute,
        leading: SvgPicture.asset(
          myTuneSideMenuIcon,
          height: 18,
        )),
    SideMenuModel(myWishlistStr, myWishlistRoute,
        leading: Icon(Icons.favorite_outline, size: 18, color: grey)),
    // leading: SvgPicture.asset(
    //   wishlistSideMenuIcon,
    //   height: 18,
    // )

    // SideMenuModel(rewardPointStr, rewardPointRoute,
    //     leading: Icon(
    //       color: grey,
    //       Icons.emoji_events_outlined,
    //       size: 18,
    //     )),

    SideMenuModel("", "",
        leadingIconData: CupertinoIcons.gift, isdivider: true),

    SideMenuModel(moodDetectStr, moodDetectRoute,
        leading: Image.asset(
          sideMenuMoodIcon,
          color: grey,
          width: 20,
          height: 20,
        )),

    SideMenuModel(musicBoxStr, musicBoxRoute,
        leading: SvgPicture.asset(
          musicBoxSideMenuIcon,
          color: grey,
        )),
    SideMenuModel(artistStr, topArtistsRoute,
        leading: Icon(
          color: grey,
          Icons.mic_external_on,
          size: 18,
        )),
    SideMenuModel(faqCStr, faqRoute,
        leading: Icon(
          color: grey,
          Icons.forum_outlined,
          size: 18,
        )),
    SideMenuModel(aboutStr, aboutRoute,
        leading: Icon(
          color: grey,
          Icons.info_outline,
          size: 18,
        )),
    SideMenuModel("", "",
        leadingIconData: CupertinoIcons.gift, isdivider: true),

    SideMenuModel(darkModeStr, "",
        leading: Icon(
          Icons.dark_mode,
          size: 18,
          color: grey,
        )),
    SideMenuModel(logoutStr, "",
        leading: SvgPicture.asset(
          logoutSideMenuIcon,
          color: grey,
        )),
  ];
}

class SideMenuModel {
  String title;
  bool isContainSubMenu;
  String routeName;
  Widget? leading;
  Widget? tailing;
  IconData? leadingIconData;
  bool isdivider;

  SideMenuModel(this.title, this.routeName,
      {this.isdivider = false,
      this.isContainSubMenu = false,
      this.leading,
      this.tailing,
      this.leadingIconData});
}
