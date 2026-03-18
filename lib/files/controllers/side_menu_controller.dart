import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class SideMenuController extends GetxController {
  Rx<SideMenuModel> selectedCard = SideMenuModel(homeStr, homeRoute).obs;
  List<SideMenuModel> sideMenuList = [
    SideMenuModel(homeStr, homeRoute, leadingIconData: CupertinoIcons.home),
    // SideMenuModel(myProfileStr, profileRoute,
    //     leadingIconData: CupertinoIcons.home),
    SideMenuModel(myTunezStr, myTunesRoute,
        leadingIconData: CupertinoIcons.home),
    SideMenuModel(myWishlistStr, myWishlistRoute,
        leadingIconData: CupertinoIcons.question_circle),
    SideMenuModel(rewardPointStr, rewardPointRoute,
        leadingIconData: CupertinoIcons.gift),

    SideMenuModel("", "",
        leadingIconData: CupertinoIcons.gift, isdivider: true),

    SideMenuModel(musicBoxStr, musicBoxRoute,
        leadingIconData: CupertinoIcons.question_circle),
    SideMenuModel(artistStr, artistsRoute,
        leadingIconData: CupertinoIcons.question_circle),
    SideMenuModel(faqCStr, faqRoute,
        leadingIconData: CupertinoIcons.info_circle),
    SideMenuModel(aboutStr, aboutRoute,
        leadingIconData: CupertinoIcons.info_circle),
    SideMenuModel("", "",
        leadingIconData: CupertinoIcons.gift, isdivider: true),

    SideMenuModel(darkModeStr, "", leadingIconData: CupertinoIcons.gift),
    SideMenuModel(logoutStr, "", leadingIconData: CupertinoIcons.gift),
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
